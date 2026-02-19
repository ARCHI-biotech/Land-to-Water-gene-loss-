#!/usr/bin/env python3
import os
import pandas as pd
import subprocess
import glob

# -----------------------------
# CONFIG
# -----------------------------
WINDOW_ROOT = "/media/disk1/task/project_1/synteny_pipeline/data/extraction_windows"
GENOME_DIR = "/media/disk1/task/project_1/step_5/genomes"

OUTPUT_ROOT = "/media/disk1/task/project_1/synteny_pipeline/data/extracted_regions"
os.makedirs(OUTPUT_ROOT, exist_ok=True)

# -----------------------------
# LOOP OVER FOCAL GENES
# -----------------------------
for gene_dir in glob.glob(os.path.join(WINDOW_ROOT, "*")):

    if not os.path.isdir(gene_dir):
        continue

    focal_gene = os.path.basename(gene_dir)
    print(f"\n[INFO] Processing focal gene: {focal_gene}")

    # output folder per gene
    gene_out_dir = os.path.join(OUTPUT_ROOT, focal_gene)
    os.makedirs(gene_out_dir, exist_ok=True)

    # -----------------------------
    # LOOP OVER SPECIES FILES
    # -----------------------------
    for tsv_file in glob.glob(os.path.join(gene_dir, "*_extraction_window.tsv")):

        df = pd.read_csv(tsv_file, sep="\t")

        if df.empty:
            continue

        row = df.iloc[0]

        species = row["Species"]
        chrom = row["Chromosome"]
        start = int(row["Window_Start"])
        end = int(row["Window_End"])

        genome_file = os.path.join(
            GENOME_DIR,
            f"{species}_genomic.cleaned.fna"
        )

        if not os.path.exists(genome_file):
            print(f"[WARNING] Genome missing: {species}")
            continue

        # species output folder
        species_out_dir = os.path.join(gene_out_dir, species)
        os.makedirs(species_out_dir, exist_ok=True)

        out_fasta = os.path.join(
            species_out_dir,
            f"{focal_gene}_{species}_region.fna"
        )

        region = f"{chrom}:{start}-{end}"

        try:
            with open(out_fasta, "w") as out_handle:
                subprocess.run(
                    ["samtools", "faidx", genome_file, region],
                    check=True,
                    stdout=out_handle
                )

            print(f"[OK] {focal_gene} | {species}")

        except subprocess.CalledProcessError:
            print(f"[FAILED] {focal_gene} | {species}")

print("\n[DONE] All genomic regions extracted.")
(base) srishti@C9X299-PG300F:/media/disk1/task/pr
