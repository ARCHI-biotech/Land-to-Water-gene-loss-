 cat script_10_version2_tblastn_neighbouring_genes.sh 
#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob

# -----------------------------
# CONFIG
# -----------------------------
FA_DIR="/media/disk1/task/project_1/synteny_pipeline/data/results_per_gene_fasta_py"
DB_DIR="/media/disk1/task/project_1/synteny_pipeline/data/extracted_regions_db"
OUT_DIR="/media/disk1/task/project_1/synteny_pipeline/data/tblastn_results_neighbors"

THREADS=4

mkdir -p "$OUT_DIR"

# -----------------------------
# LOOP OVER FOCAL GENES
# -----------------------------
for focal_gene_dir in "$DB_DIR"/*; do

    [[ ! -d "$focal_gene_dir" ]] && continue

    focal_gene=$(basename "$focal_gene_dir")
    echo "[INFO] Processing focal gene: $focal_gene"

    fasta_dir="$FA_DIR/$focal_gene"
    [[ ! -d "$fasta_dir" ]] && {
        echo "[WARNING] Missing FASTA dir for $focal_gene"
        continue
    }

    # -----------------------------
    # LOOP OVER NEIGHBOUR GENES
    # -----------------------------
    for faa_file in "$fasta_dir"/*.faa; do

        file_base=$(basename "$faa_file")

        # Skip focal gene itself
        if [[ "$file_base" == "$focal_gene.faa" ]]; then
            continue
        fi

        neigh_gene=$(basename "$faa_file" .faa)
        echo "  [RUNNING] neighbour: $neigh_gene"

        neigh_out_dir="$OUT_DIR/$focal_gene/$neigh_gene"
        mkdir -p "$neigh_out_dir"

        # -----------------------------
        # LOOP OVER SPECIES DBs
        # -----------------------------
        for species_dir in "$focal_gene_dir"/*; do

            [[ ! -d "$species_dir" ]] && continue

            species=$(basename "$species_dir")
            db_prefix="$species_dir/${focal_gene}_${species}_region_db"

            if [[ ! -f "${db_prefix}.nin" ]]; then
                echo "    [SKIP] Missing DB for $species"
                continue
            fi

            out_file="$neigh_out_dir/${focal_gene}_${neigh_gene}_vs_${species}.tblastn.tsv"

            tblastn \
                -query "$faa_file" \
                -db "$db_prefix" \
                -out "$out_file" \
                -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs" \
                -num_threads $THREADS

            echo "    [DONE] $neigh_gene vs $species"
        done
    done
done

echo "[DONE] All neighbouring gene tblastn completed."
