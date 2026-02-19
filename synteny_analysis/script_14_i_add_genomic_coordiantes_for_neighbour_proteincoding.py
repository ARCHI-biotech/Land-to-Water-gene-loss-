#!/usr/bin/env python3
import os
import pandas as pd
import glob

INPUT_ROOT = "/media/disk1/task/project_1/synteny_pipeline/data/tblastn_results_neighbors"
OUTPUT_ROOT = "/media/disk1/task/project_1/synteny_pipeline/data/neighbouring_genes_genomic_coordinates"

print("[INFO] Computing genomic coordinates for protein coding neighbours")

for focal_gene_dir in glob.glob(os.path.join(INPUT_ROOT, "*")):
    if not os.path.isdir(focal_gene_dir):
        continue

    focal_gene = os.path.basename(focal_gene_dir)

    for neigh_gene_dir in glob.glob(os.path.join(focal_gene_dir, "*")):
        if not os.path.isdir(neigh_gene_dir):
            continue

        neigh_gene = os.path.basename(neigh_gene_dir)

        for best_file in glob.glob(os.path.join(neigh_gene_dir, "*.best.tsv")):

            df = pd.read_csv(best_file, sep="\t")

            if df.empty:
                continue

            chrom_field = df.loc[0, "Chromosome"]

            # Skip if already converted
            if ":" not in chrom_field:
                continue

            chrom, region = chrom_field.split(":")
            region_start = int(region.split("-")[0])

            # local coordinates already stored
            local_start = int(df.loc[0, "Hit_Start"])
            local_end   = int(df.loc[0, "Hit_End"])

            genomic_start = region_start + local_start - 1
            genomic_end   = region_start + local_end   - 1

            df["Genomic_Start"] = genomic_start
            df["Genomic_End"] = genomic_end

            # keep only chromosome name
            df["Chromosome"] = chrom

            # insert after Status
            cols = df.columns.tolist()
            cols.remove("Genomic_Start")
            cols.remove("Genomic_End")

            idx = cols.index("Status") + 1
            cols.insert(idx, "Genomic_Start")
            cols.insert(idx + 1, "Genomic_End")

            df = df[cols]

            # output path
            out_dir = os.path.join(
                OUTPUT_ROOT,
                focal_gene,
                neigh_gene
            )
            os.makedirs(out_dir, exist_ok=True)

            out_file = os.path.join(out_dir, os.path.basename(best_file))

            df.to_csv(out_file, sep="\t", index=False)

            print(f"[OK] {focal_gene} | {neigh_gene} | {os.path.basename(best_file)}")

print("[DONE] Genomic coordinates generated")
