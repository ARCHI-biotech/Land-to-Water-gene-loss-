#!/usr/bin/env python3
import os
import pandas as pd
import glob

# -----------------------------
# CONFIG
# -----------------------------
COORD_DIR = "/media/disk1/task/project_1/synteny_pipeline/data/neighbour_summary"
GENE_COORD_ROOT = "/media/disk1/task/project_1/synteny_pipeline/data/neighbouring_genes_genomic_coordinates"
SPECIES_LIST = "/media/disk1/task/project_1/synteny_pipeline/data/species_list.txt"

OUT_ROOT = "/media/disk1/task/project_1/synteny_pipeline/data/synteny_tables"
os.makedirs(OUT_ROOT, exist_ok=True)

print("[INFO] Building clean synteny tables")

# -----------------------------
# Load species list
# -----------------------------
with open(SPECIES_LIST) as f:
    species_list = [l.strip() for l in f if l.strip()]

# -----------------------------
# Loop focal genes
# -----------------------------
for coord_file in os.listdir(COORD_DIR):

    if not coord_file.endswith("_neighbors_coordinates.tsv"):
        continue

    focal_gene = coord_file.replace("_neighbors_coordinates.tsv", "")
    print(f"[INFO] Processing {focal_gene}")

    coord_path = os.path.join(COORD_DIR, coord_file)

    ref_df = pd.read_csv(coord_path, sep="\t")
    ref_df = ref_df.sort_values("start")

    gene_order = ref_df["gene"].tolist()

    rows = []
    gene_dir = os.path.join(GENE_COORD_ROOT, focal_gene)

    for species in species_list:

        row = {"Species": species}

        for gene in gene_order:

            # focal gene stored differently
            if gene == focal_gene:
                gene_subdir = os.path.join(
                    gene_dir,
                    f"{gene}_focalgene"
                )
            else:
                gene_subdir = os.path.join(gene_dir, gene)

            if not os.path.exists(gene_subdir):
                row[gene] = "ABSENT"
                continue

            # strict match for species
            pattern = os.path.join(
                gene_subdir,
                f"*_{species}.best.tsv"
            )

            matches = glob.glob(pattern)

            if len(matches) == 0:
                row[gene] = "ABSENT"
                continue

            file_path = matches[0]

            if os.path.getsize(file_path) == 0:
                row[gene] = "NA"
                continue

            df = pd.read_csv(file_path, sep="\t")

            if df.empty:
                row[gene] = "NA"
                continue

            # prefer genomic coordinates
            if "Genomic_Start" in df.columns:
                row[gene] = int(df.iloc[0]["Genomic_Start"])
            else:
                row[gene] = int(df.iloc[0]["Hit_Start"])

        rows.append(row)

    out_df = pd.DataFrame(rows)

    cols = ["Species"] + gene_order
    out_df = out_df[cols]

    out_file = os.path.join(
        OUT_ROOT,
        f"{focal_gene}_synteny_table.tsv"
    )

    out_df.to_csv(out_file, sep="\t", index=False)

    print(f"[DONE] {out_file}")

print("[ALL DONE] Clean synteny tables created.")
