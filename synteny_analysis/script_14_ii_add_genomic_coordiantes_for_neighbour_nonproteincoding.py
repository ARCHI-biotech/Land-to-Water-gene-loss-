#!/usr/bin/env python3
import os
import pandas as pd
import glob

INPUT_ROOT = "/media/disk1/task/project_1/synteny_pipeline/data/blast_non_proteincoding"
OUTPUT_ROOT = "/media/disk1/task/project_1/synteny_pipeline/data/neighbouring_genes_genomic_coordinates"

print("[INFO] Generating genomic coordinates for non-protein coding genes")

for focal_gene_dir in glob.glob(os.path.join(INPUT_ROOT, "*")):
    if not os.path.isdir(focal_gene_dir):
        continue

    focal_gene = os.path.basename(focal_gene_dir)

    for gene_dir in glob.glob(os.path.join(focal_gene_dir, "*")):
        if not os.path.isdir(gene_dir):
            continue

        gene_id = os.path.basename(gene_dir)

        for species_dir in glob.glob(os.path.join(gene_dir, "*")):
            species = os.path.basename(species_dir)

            best_files = glob.glob(os.path.join(species_dir, "*.best.tsv"))
            if not best_files:
                continue

            best_file = best_files[0]

            df = pd.read_csv(best_file, sep="\t")

            chrom_field = df.loc[0, "Chromosome"]

            if ":" not in chrom_field:
                # already processed
                continue

            chrom, region = chrom_field.split(":")
            region_start = int(region.split("-")[0])

            df["Hit_Start"] = df["Hit_Start"].astype(int)
            df["Hit_End"] = df["Hit_End"].astype(int)

            # genomic coordinates
            df["Genomic_Start"] = region_start + df["Hit_Start"] - 1
            df["Genomic_End"] = region_start + df["Hit_End"] - 1

            # clean chromosome name
            df["Chromosome"] = chrom

            # place genomic columns after Status
            cols = df.columns.tolist()
            cols.remove("Genomic_Start")
            cols.remove("Genomic_End")

            status_idx = cols.index("Status") + 1
            cols.insert(status_idx, "Genomic_Start")
            cols.insert(status_idx + 1, "Genomic_End")

            df = df[cols]

            # output folder
            out_dir = os.path.join(OUTPUT_ROOT, focal_gene, gene_id)
            os.makedirs(out_dir, exist_ok=True)

            out_file = os.path.join(
                out_dir,
                f"{focal_gene}_{gene_id}_vs_{species}.best.tsv"
            )

            df.to_csv(out_file, sep="\t", index=False)

            print(f"[OK] {focal_gene} | {gene_id} | {species}")

print("[DONE] Non-protein coding genomic coordinates generated")

