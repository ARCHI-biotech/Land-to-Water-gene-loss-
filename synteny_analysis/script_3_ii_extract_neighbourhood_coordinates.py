#!/usr/bin/env python3

import os

# -----------------------------
# Paths
# -----------------------------
NEIGHBOR_DIR = "/media/disk1/task/project_1/synteny_pipeline/data/neighbours_output"
BED_FILE = "/media/disk1/task/project_1/synteny_pipeline/data/genes.bed"
OUTPUT_DIR = "/media/disk1/task/project_1/synteny_pipeline/data/neighbour_summary"

os.makedirs(OUTPUT_DIR, exist_ok=True)

# -----------------------------
# Load genes.bed into memory
# -----------------------------
bed_records = {}
with open(BED_FILE) as bed:
    for line in bed:
        fields = line.strip().split("\t")
        if len(fields) < 6:
            continue
        chrom, start, end, gene, score, strand = fields
        bed_records[gene] = line.strip()

# -----------------------------
# Process each neighbors file
# -----------------------------
for fname in os.listdir(NEIGHBOR_DIR):
    if not fname.endswith("_neighbors.txt"):
        continue

    focal_gene = fname.replace("_neighbors.txt", "")
    input_path = os.path.join(NEIGHBOR_DIR, fname)
    output_path = os.path.join(
        OUTPUT_DIR, f"{focal_gene}_neighbors_coordinates.tsv"
    )

    with open(input_path) as f, open(output_path, "w") as out:
        out.write("chrom\tstart\tend\tgene\tscore\tstrand\n")

        for line in f:
            if not line.strip():
                continue
            chrom, gene = line.strip().split("\t")

            if gene in bed_records:
                out.write(bed_records[gene] + "\n")
            else:
                print(f"[WARNING] {gene} not found in genes.bed")

    print(f"[DONE] {focal_gene} → {output_path}")

print("\nAll neighbor coordinate files generated.")
