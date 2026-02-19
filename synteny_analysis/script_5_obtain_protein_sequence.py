#!/usr/bin/env python3
import os
from pathlib import Path
from Bio import SeqIO

# -------------------------------
# Paths
# -------------------------------
TSV_DIR = Path("/media/disk1/task/project_1/synteny_pipeline/data/neighbour_summary")
PROTEIN_FASTA = Path("/media/disk1/task/project_1/synteny_pipeline/data/chelonia_mydas_proteins_clean.faa")
OUTPUT_DIR = Path("/media/disk1/task/project_1/synteny_pipeline/data/results_per_gene_fasta_py")
OUTPUT_DIR.mkdir(exist_ok=True)

# Load all protein sequences into a dictionary for fast lookup
print("[INFO] Loading protein FASTA...")
protein_dict = {rec.id: rec for rec in SeqIO.parse(PROTEIN_FASTA, "fasta")}
print(f"[INFO] {len(protein_dict)} proteins loaded.")

# -------------------------------
# Loop over each focal gene TSV
# -------------------------------
for tsv_file in TSV_DIR.glob("*_neighbour_summary.tsv"):
    focal_gene = tsv_file.stem.replace("_neighbour_summary", "")
    print(f"[INFO] Processing focal gene: {focal_gene}")

    gene_dir = OUTPUT_DIR / focal_gene
    gene_dir.mkdir(exist_ok=True)

    with open(tsv_file) as f:
        header = f.readline()  # skip header
        for line in f:
            gene_id, gene_type, longest_protein = line.strip().split("\t")

            if gene_type == "protein_coding" and longest_protein != "NA":
                if longest_protein in protein_dict:
                    out_file = gene_dir / f"{gene_id}.faa"
                    SeqIO.write(protein_dict[longest_protein], out_file, "fasta")
                    print(f"[OK] {gene_id} -> {longest_protein}")
                else:
                    print(f"[WARNING] Protein {longest_protein} not found for {gene_id}")
            else:
                # Save gene type info for non-coding or unknown
                out_file = gene_dir / f"{gene_id}_status.txt"
                with open(out_file, "w") as o:
                    o.write(f"{gene_type}\n")
                print(f"[INFO] {gene_id} is {gene_type}")

print("[DONE] All focal genes processed. Results in", OUTPUT_DIR)
