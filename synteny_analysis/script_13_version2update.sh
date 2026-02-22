#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob

NONCODING_DIR="/media/disk1/task/project_1/synteny_pipeline/data/non-proteincodinggenes"
DB_DIR="/media/disk1/task/project_1/synteny_pipeline/data/extracted_regions_db"
TSV="/media/disk1/task/project_1/synteny_pipeline/data/check_blast_non_proteincoding.tsv"
OUT_DIR="/media/disk1/task/project_1/synteny_pipeline/data/blast_non_proteincoding"

mkdir -p "$OUT_DIR"

# Skip header
tail -n +2 "$TSV" | while IFS=$'\t' read -r focal_gene gene_id gene_type seq_len blast_task; do

    query_fa="$NONCODING_DIR/$focal_gene/$gene_id.fa"
    [[ ! -f "$query_fa" ]] && { echo "[WARN] Missing query: $query_fa"; continue; }

    gene_db_dir="$DB_DIR/$focal_gene"
    [[ ! -d "$gene_db_dir" ]] && { echo "[WARN] Missing DB dir: $gene_db_dir"; continue; }

    echo "[INFO] BLASTing $gene_id ($blast_task)"

    # Loop over species DBs
    for species_dir in "$gene_db_dir"/*; do
        species=$(basename "$species_dir")

        db_prefix="$species_dir/${focal_gene}_${species}_region_db"
        [[ ! -f "${db_prefix}.nin" ]] && continue

        outdir="$OUT_DIR/$focal_gene/$gene_id/$species"
        mkdir -p "$outdir"

        outfile="$outdir/${gene_id}_vs_${species}.blastn.tsv"

        blastn \
            -task "$blast_task" \
            -query "$query_fa" \
            -db "$db_prefix" \
            -out "$outfile" \
            -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs" \
            -evalue 1e-5 \
            -max_target_seqs 10 \
            -num_threads 4

        # If BLAST finds nothing, add header
        if [[ ! -s "$outfile" ]]; then
            echo -e "qseqid\tsseqid\tpident\tlength\tmismatch\tgapopen\tqstart\tqend\tsstart\tsend\tevalue\tbitscore\tqcovs" > "$outfile"
        fi

    done
done

echo "[DONE] All BLAST searches completed"
