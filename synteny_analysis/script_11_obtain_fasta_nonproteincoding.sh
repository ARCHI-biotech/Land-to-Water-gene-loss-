#!/usr/bin/env bash
set -euo pipefail

GENOME="/media/disk1/task/project_1/synteny_pipeline/data/chelonia_mydas_genome.fna"
NEIGH_DIR="/media/disk1/task/project_1/synteny_pipeline/data/neighbour_summary"
GENES_BED="/media/disk1/task/project_1/synteny_pipeline/data/genes.bed"
OUTDIR="/media/disk1/task/project_1/synteny_pipeline/data/non-proteincodinggenes"

# Check if samtools is available
if ! command -v samtools &> /dev/null; then
    echo "[ERROR] samtools not found. Please install it first."
    exit 1
fi

# Index genome if needed
if [[ ! -f "${GENOME}.fai" ]]; then
    echo "[INFO] Indexing genome with samtools faidx"
    samtools faidx "$GENOME"
fi

mkdir -p "$OUTDIR"

for neigh_file in "${NEIGH_DIR}"/*_neighbour_summary.tsv; do
    focal_gene=$(basename "$neigh_file" _neighbour_summary.tsv)
    echo "[INFO] Processing focal gene: $focal_gene"

    focal_out="${OUTDIR}/${focal_gene}"
    mkdir -p "$focal_out"

    # Read neighbour summary: gene_id + gene_type
    tail -n +2 "$neigh_file" | while IFS=$'\t' read -r gene_id gene_type rest; do

        # STRICT filter: only non-protein-coding
        if [[ "$gene_type" == "protein_coding" ]]; then
            continue
        fi

        # Fetch coordinates from genes.bed
        bed_line=$(awk -v g="$gene_id" '$4==g' "$GENES_BED")

        if [[ -z "$bed_line" ]]; then
            echo "  [WARN] Coordinates not found for $gene_id"
            continue
        fi

        chrom=$(echo "$bed_line" | cut -f1)
        bed_start=$(echo "$bed_line" | cut -f2)
        bed_end=$(echo "$bed_line" | cut -f3)

        # Convert BED 0-based -> samtools 1-based
        faidx_start=$((bed_start + 1))
        faidx_end=$bed_end

        out_fa="${focal_out}/${gene_id}.fa"

        echo "  [EXTRACT] $gene_id ($chrom:${faidx_start}-${faidx_end})"

        samtools faidx "$GENOME" "${chrom}:${faidx_start}-${faidx_end}" > "$out_fa"

    done
done

echo "[DONE] Only non-protein-coding neighbouring genes extracted"
