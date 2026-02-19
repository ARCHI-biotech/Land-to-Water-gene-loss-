#!/usr/bin/env bash
set -euo pipefail

# Directories
NEIGH_DIR="/media/disk1/task/project_1/synteny_pipeline/data/neighbour_summary"
EXTRACTED_DIR="/media/disk1/task/project_1/synteny_pipeline/data/non-proteincodinggenes"
OUT_FILE="/media/disk1/task/project_1/synteny_pipeline/data/check_blast_non_proteincoding.tsv"

# Header
echo -e "focal_gene\tgene_id\tgene_type\tseq_len\tblast_task" > "$OUT_FILE"

# Loop over neighbour summary files
for neigh_file in "$NEIGH_DIR"/*_neighbour_summary.tsv; do
    focal_gene=$(basename "$neigh_file" _neighbour_summary.tsv)

    tail -n +2 "$neigh_file" | while IFS=$'\t' read -r gene_id gene_type _; do
        # Skip protein-coding genes
        if [[ "$gene_type" == "protein_coding" ]]; then
            continue
        fi

        query_fa="$EXTRACTED_DIR/$focal_gene/$gene_id.fa"

        if [[ ! -f "$query_fa" ]]; then
            # Skip if FASTA does not exist (only include existing non-protein-coding FASTAs)
            continue
        fi

        # Compute sequence length (exclude FASTA header)
        seq_len=$(grep -v ">" "$query_fa" | tr -d '\n' | wc -c)        

        # Determine recommended BLAST task
        if [[ "$gene_type" == "snoRNA" || "$seq_len" -lt 200 ]]; then
            blast_task="blastn-short"
        else
            blast_task="dc-megablast"
        fi

        # Append info to TSV
        echo -e "${focal_gene}\t${gene_id}\t${gene_type}\t${seq_len}\t${blast_task}" >> "$OUT_FILE"
    done
done

echo "[DONE] Summary TSV created at $OUT_FILE"
