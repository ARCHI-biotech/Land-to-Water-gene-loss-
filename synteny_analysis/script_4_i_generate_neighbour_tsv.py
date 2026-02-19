#!/usr/bin/env python3
import os
from collections import defaultdict
from Bio import SeqIO

# --------------------------
# Paths & parameters
# --------------------------
BED_FILE = "/media/disk1/task/project_1/synteny_pipeline/data/genes.bed"
GFF_FILE = "/media/disk1/task/project_1/synteny_pipeline/data/chelonia_mydas.gff"
PROTEIN_FASTA = "/media/disk1/task/project_1/synteny_pipeline/data/chelonia_mydas_proteins.faa"
GENE_IDS = "/media/disk1/task/project_1/synteny_pipeline/data/gene_ids.txt"
N = 5  # number of neighbors upstream and downstream
OUTPUT_DIR = "/media/disk1/task/project_1/synteny_pipeline/data/neighbour_summary"

os.makedirs(OUTPUT_DIR, exist_ok=True)

# --------------------------
# Step 1: Read BED file to group genes by chromosome
# --------------------------
genes_by_chr = defaultdict(list)
gene_info = dict()  # gene_id -> chromosome, start, end, strand

with open(BED_FILE) as f:
    for line in f:
        fields = line.strip().split("\t")
        if len(fields) < 6:
            continue
        chrom, start, end, gene, score, strand = fields[:6]
        genes_by_chr[chrom].append(gene)
        gene_info[gene] = {"chrom": chrom, "start": start, "end": end, "strand": strand}

# --------------------------
# Step 2: Read GFF to get gene type and protein IDs
# --------------------------
gene_type_map = dict()      # gene_id -> type (protein_coding, lncRNA, pseudogene)
gene_proteins = defaultdict(list)  # gene_id -> list of protein IDs

with open(GFF_FILE) as f:
    for line in f:
        if line.startswith("#"):
            continue
        fields = line.strip().split("\t")
        if len(fields) < 9:
            continue
        feature_type = fields[2]
        attrs = fields[8]
        if feature_type == "gene":
            gene_match = None
            type_match = None
            for attr in attrs.split(";"):
                if attr.startswith("gene="):
                    gene_match = attr.replace("gene=", "").strip()
                if attr.startswith("gene_biotype=") or attr.startswith("biotype="):
                    type_match = attr.split("=")[1].strip()
            if gene_match:
                gene_type_map[gene_match] = type_match if type_match else "unknown"
        elif feature_type == "CDS":
            gene_match = None
            protein_match = None
            for attr in attrs.split(";"):
                if attr.startswith("gene="):
                    gene_match = attr.replace("gene=", "").strip()
                if attr.startswith("protein_id="):
                    protein_match = attr.replace("protein_id=", "").strip()
            if gene_match and protein_match:
                gene_proteins[gene_match].append(protein_match)

# --------------------------
# Step 3: Read protein FASTA to get protein lengths
# --------------------------
prot_len = dict()
for rec in SeqIO.parse(PROTEIN_FASTA, "fasta"):
    prot_len[rec.id] = len(rec.seq)

# --------------------------
# Step 4: Select longest protein for each gene
# --------------------------
longest_protein = dict()  # gene_id -> longest XP ID

for gene, prots in gene_proteins.items():
    if prots:
        best = max(prots, key=lambda x: prot_len.get(x, 0))
        longest_protein[gene] = best

# --------------------------
# Step 5: Read focal genes
# --------------------------
with open(GENE_IDS) as f:
    focal_genes = [line.strip() for line in f if line.strip()]

# --------------------------
# Step 6: Extract neighbors and write TSV per focal gene
# --------------------------
for focal in focal_genes:
    # find chromosome
    chrom = gene_info.get(focal, {}).get("chrom")
    if not chrom or chrom not in genes_by_chr:
        print(f"[WARNING] Focal gene {focal} not found in BED. Skipping.")
        continue

    genes_on_chr = genes_by_chr[chrom]
    idx = genes_on_chr.index(focal)
    start = max(0, idx - N)
    end = min(len(genes_on_chr), idx + N + 1)
    neighborhood = genes_on_chr[start:end]  # includes focal

    # write TSV
    out_file = os.path.join(OUTPUT_DIR, f"{focal}_neighbour_summary.tsv")
    with open(out_file, "w") as out:
        out.write("gene_id\tgene_type\tlongest_protein\n")
        for g in neighborhood:
            gtype = gene_type_map.get(g, "unknown")
            prot = longest_protein.get(g, "NA") if gtype == "protein_coding" else gtype
            out.write(f"{g}\t{gtype}\t{prot}\n")

print(f"Neighbour summary TSVs written to {OUTPUT_DIR}")
