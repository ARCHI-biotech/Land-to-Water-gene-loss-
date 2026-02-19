#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob

# -----------------------------
# CONFIG
# -----------------------------
EXTRACTED_ROOT="/media/disk1/task/project_1/synteny_pipeline/data/extracted_regions"
DB_ROOT="/media/disk1/task/project_1/synteny_pipeline/data/extracted_regions_db"

mkdir -p "$DB_ROOT"

echo "[INFO] Creating BLAST databases from extracted regions"

# -----------------------------
# LOOP OVER FOCAL GENES
# -----------------------------
for gene_dir in "$EXTRACTED_ROOT"/*; do
    [[ ! -d "$gene_dir" ]] && continue

    focal_gene=$(basename "$gene_dir")
    echo "[INFO] Processing focal gene: $focal_gene"

    gene_db_dir="$DB_ROOT/$focal_gene"
    mkdir -p "$gene_db_dir"

    # -----------------------------
    # LOOP OVER SPECIES
    # -----------------------------
    for species_dir in "$gene_dir"/*; do
        [[ ! -d "$species_dir" ]] && continue

        species=$(basename "$species_dir")

        fasta=$(find "$species_dir" -maxdepth 1 -name "*.fna")

        if [[ -z "$fasta" ]]; then
            echo "[WARNING] No FASTA found for $focal_gene | $species"
            continue
        fi

        out_species_db_dir="$gene_db_dir/$species"
        mkdir -p "$out_species_db_dir"

        db_prefix="$out_species_db_dir/${focal_gene}_${species}_region_db"

        echo "  [RUNNING] makeblastdb for $focal_gene | $species"

        makeblastdb \
            -in "$fasta" \
            -dbtype nucl \
            -parse_seqids \
            -out "$db_prefix" \
            > /dev/null

        echo "  [OK] DB created"
    done
done

echo "[DONE] All BLAST databases created."
