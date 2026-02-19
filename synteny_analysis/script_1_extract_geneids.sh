#!/usr/bin/env bash

# -------------------------
# Hard-coded paths
# -------------------------
INPUT_FILE="/media/disk1/task/project_1/synteny_pipeline/data/m_reevesii_all_chromosomes_strong_gene_loss_mutburden5.tsv"
OUTPUT_FILE="/media/disk1/task/project_1/synteny_pipeline/data/gene_ids.txt"

# -------------------------
# Extract unique GeneIDs
# -------------------------
awk -F'\t' 'NR>1 {print $2}' "$INPUT_FILE" | sort -u > "$OUTPUT_FILE"
