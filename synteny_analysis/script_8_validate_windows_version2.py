#!/usr/bin/env python3
import os
import pandas as pd

NEIGHBOR_DIR = "/media/disk1/task/project_1/synteny_pipeline/data/neighbour_summary"
WINDOW_DIR = "/media/disk1/task/project_1/synteny_pipeline/data/extraction_windows"

print("\nChecking Chelonia extraction windows\n")

for gene in os.listdir(WINDOW_DIR):

    gene_dir = os.path.join(WINDOW_DIR, gene)
    if not os.path.isdir(gene_dir):
        continue

    # ---------- neighbor reference ----------
    neigh_file = os.path.join(
        NEIGHBOR_DIR,
        f"{gene}_neighbors_coordinates.tsv"
    )

    if not os.path.exists(neigh_file):
        print(f"[SKIP] No neighbor file for {gene}")
        continue

    neigh_df = pd.read_csv(neigh_file, sep="\t")

    ref_start = neigh_df["start"].min()
    ref_end   = neigh_df["end"].max()
    ref_span  = ref_end - ref_start

    # ---------- Chelonia window ----------
    win_file = os.path.join(
        gene_dir,
        f"{gene}_Chelonia_mydas_extraction_window.tsv"
    )

    if not os.path.exists(win_file):
        print(f"[SKIP] No Chelonia window for {gene}")
        continue

    win_df = pd.read_csv(win_file, sep="\t")

    win_start = win_df["Window_Start"].iloc[0]
    win_end   = win_df["Window_End"].iloc[0]
    win_span  = win_end - win_start

    # ---------- comparison ----------
    if win_span < ref_span:
        print(f"[PROBLEM] {gene}")
        print(f"  Reference span : {ref_span}")
        print(f"  Extracted span : {win_span}")
    else:
        print(f"[OK] {gene}")
        print(f"  Reference span : {ref_span}")
        print(f"  Extracted span : {win_span}")

print("\nValidation complete\n")
