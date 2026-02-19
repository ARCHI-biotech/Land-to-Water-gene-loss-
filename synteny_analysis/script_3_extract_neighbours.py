#!/usr/bin/env python3
import os
from collections import defaultdict

# -------------------------------
# Hard-coded paths and parameters
# -------------------------------
BED_FILE = "/media/disk1/task/project_1/synteny_pipeline/data/genes.bed"
GENE_FILE = "/media/disk1/task/project_1/synteny_pipeline/data/gene_ids.txt"
N = 5
OUTPUT_DIR = "/media/disk1/task/project_1/synteny_pipeline/data/neighbours_output"

# Create output folder automatically
os.makedirs(OUTPUT_DIR, exist_ok=True)

# --------------------------------------------------
# Read BED6 and group genes by chromosome
# --------------------------------------------------
genes_by_chr = defaultdict(list)
with open(BED_FILE) as f:
    for line in f:
        fields = line.strip().split("\t")
        if len(fields) < 4:
            continue
        chrom, start, end, gene = fields[:4]
        genes_by_chr[chrom].append(gene)

# --------------------------------------------------
# Read focal genes
# --------------------------------------------------
with open(GENE_FILE) as f:
    focal_genes = [line.strip() for line in f if line.strip()]

# --------------------------------------------------
# Extract neighbors for each focal gene
# --------------------------------------------------
for focal_gene in focal_genes:
    found = False
    output_path = os.path.join(OUTPUT_DIR, f"{focal_gene}_neighbors.txt")
    with open(output_path, "w") as out:
        for chrom, genes in genes_by_chr.items():
            if focal_gene in genes:
                i = genes.index(focal_gene)
                start = max(0, i - N)
                end = min(len(genes), i + N + 1)
                neighbors = genes[start:end]  # Includes focal gene
                for g in neighbors:
                    out.write(f"{chrom}\t{g}\n")
                found = True
                break
    if not found:
        print(f"Warning: Gene {focal_gene} not found in BED")

print(f"Finished extracting neighbors. Output folder: {OUTPUT_DIR}")
(base) srishti@C9X299-PG300F:/media/disk1/task/project_1/synteny_pipeli
