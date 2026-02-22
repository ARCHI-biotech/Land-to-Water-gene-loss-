#!/usr/bin/env bash
set -euo pipefail

# -------------------------------------------------
# Hard-coded paths
# -------------------------------------------------
GTF_FILE="/media/disk1/task/project_1/synteny_pipeline/data/chelonia_mydas.gtf"
OUTPUT_BED="/media/disk1/task/project_1/synteny_pipeline/data/genes.bed"

# -------------------------------------------------
# Create output directory if needed
# -------------------------------------------------
mkdir -p "$(dirname "$OUTPUT_BED")"

# -------------------------------------------------
# GTF → BED6 (gene level, strand-aware)
# BED columns:
# 1 chrom
# 2 start (0-based)
# 3 end
# 4 gene_id
# 5 score (.)
# 6 strand
# -------------------------------------------------
awk -F'\t' '
$3 == "gene" {
    if (match($0, /gene_id "([^"]+)"/, a)) {
        chrom  = $1
        start  = $4 - 1      # GTF is 1-based
        end    = $5
        gene   = a[1]
        strand = $7

        print chrom "\t" start "\t" end "\t" gene "\t.\t" strand
    }
}
' "$GTF_FILE" \
| sort -k1,1 -k2,2n \
> "$OUTPUT_BED"
(base) srishti@C9
