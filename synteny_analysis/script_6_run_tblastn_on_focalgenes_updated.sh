#!/bin/bash

# Purpose:
# Run tblastn for all focal genes against all genomes
# and select best hit using:
#   1. highest query coverage
#   2. then highest bitscore

set -euo pipefail

# -------- CONFIG --------
FASTA_BASE="/media/disk1/task/project_1/synteny_pipeline/data/results_per_gene_fasta_py"
GENOMES_DIR="/media/disk1/task/project_1/step_5/blast_db"
OUTPUT_DIR="/media/disk1/task/project_1/synteny_pipeline/data/results_per_gene_tblastn"

EVALUE=1e-10
MAX_TARGET_SEQS=20   # allow BLAST to report enough hits

mkdir -p "$OUTPUT_DIR"

# -------- LOOP OVER GENES --------
for GENE_DIR in "$FASTA_BASE"/*/; do
    GENE=$(basename "$GENE_DIR")
    echo "[INFO] Processing focal gene: $GENE"

    mkdir -p "$OUTPUT_DIR/$GENE"

    QUERY="$GENE_DIR/${GENE}.faa"
    if [ ! -f "$QUERY" ]; then
        echo "[WARNING] Missing FASTA: $QUERY"
        continue
    fi

    # -------- LOOP OVER GENOMES --------
    for DB in "$GENOMES_DIR"/*; do
        SPECIES=$(basename "$DB")

        OUTFILE="$OUTPUT_DIR/$GENE/${GENE}_vs_${SPECIES}.tsv"

        echo "[INFO] BLASTing $GENE vs $SPECIES"

        tblastn \
            -query "$QUERY" \
            -db "$DB/$SPECIES" \
            -evalue $EVALUE \
            -outfmt "6 qseqid sseqid sstart send evalue bitscore qcovs" \
            -max_target_seqs $MAX_TARGET_SEQS \
            > "$OUTFILE"

        # -------- SELECT BEST HIT --------
#        python3 - <<EOF
#import pandas as pd
#import os

#outfile = "$OUTFILE"
#bestfile = outfile + ".best.tsv"

#if not os.path.exists(outfile) or os.path.getsize(outfile) == 0:
 #   exit()

#cols = ["qseqid","sseqid","sstart","send","evalue","bitscore","qcovs"]
#df = pd.read_csv(outfile, sep="\t", header=None, names=cols)

#if df.empty:
 #   exit()

# convert numeric columns safely
#for col in ["bitscore","qcovs"]:
 #   df[col] = pd.to_numeric(df[col], errors="coerce")

#df = df.dropna(subset=["bitscore","qcovs"])

#if df.empty:
 #   exit()

# ---- improved ranking ----
#df = df.sort_values(
 #   ["qcovs", "bitscore"],
  #  ascending=False
#)

#best_hit = df.iloc[0]
#best_hit.to_frame().T.to_csv(bestfile, sep="\t", index=False)
#@EOF

  #  done
#done

#echo "[DONE] All focal gene tblastn searches completed."
