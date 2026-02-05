# Download Human F12 mRNA (GenBank format)
efetch -db nucleotide -id NM_000505.4 -format gb > F12.gbk
# Extract Exon Sequences from F12
seqret -sequence F12.gbk -feature -type exon -outseq F12_exons.fasta
extractfeat -sequence F12.gbk -type exon -outseq F12_exons.fasta
# Verifing Extracted Exons and Counting them:
head F12_exons.fasta
grep -c "^>" F12_exons.fasta
# Downloading the genome of Platanista minor:
 wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/004/363/435/GCA_004363435.1_PlaMin_v1_BIUU/GCA_004363435.1_PlaMin_v1_BIUU_genomic.fna.gz
# Unziping the file:
gunzip GCA_004363435.1_PlaMin_v1_BIUU_genomic.fna.gz
# Creating the Database for Blast:
makeblastdb -in GCA_004363435.1_PlaMin_v1_BIUU_genomic.fna -dbtype nucl -out PlaMin_Genome_DB



# Downloading the genome of Okapia johnstoni:
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/024/291/935/GCA_024291935.2_TBG_Okapi_asm_v1/GCA_024291935.2_TBG_Okapi_asm_v1_genomic.fna.gz
# Unziping the file:
gunzip GCA_024291935.2_TBG_Okapi_asm_v1_genomic.fna.gz


# Downloading the genome of Giraffa camelopardolis:
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/017/591/445/GCA_017591445.1_ASM1759144v1/GCA_017591445.1_ASM1759144v1_genomic.fna.gz
# Unziping the file:
gunzip GCA_017591445.1_ASM1759144v1_genomic.fna.gz


# Downloading the genome of Antilocapra americano:
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/051/176/615/GCA_051176615.1_mAntAme2_p1.1/GCA_051176615.1_mAntAme2_p1.1_genomic.fna.gz
# Unziping the file:
gunzip GCA_051176615.1_mAntAme2_p1.1_genomic.fna.gz


# Downloading the genome of Tragulas javanicus:
 wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/004/024/965/GCA_004024965.2_ASM402496v2/GCA_004024965.2_ASM402496v2_genomic.fna.gz
# Unziping the file:
gunzip GCA_004024965.2_ASM402496v2_genomic.fna.gz

 
# Downloading the genome of Sousa chinensis:
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/007/760/645/GCA_007760645.1_ASM776064v1/GCA_007760645.1_ASM776064v1_genomic.gbff.gz
# Unziping the file:
gunzip GCA_007760645.1_ASM776064v1_genomic.gbff.gz


############################################
# PATHS
############################################
BASE_DIR="$HOME/Dissertation"
GENOMES_DIR="$BASE_DIR/GENOMES"
GENE_DIR="$BASE_DIR/GENE"
RESULTS_DIR="$BASE_DIR/RESULTS"
QUERY="$GENE_DIR/renamed_exons.fasta"
THREADS=8
mkdir -p "$RESULTS_DIR"

# For Creation Of Database for each Species mentioned above
          By running a single command 
   ############################################
# PART 1: Create BLAST databases
############################################
for dir in "$GENOMES_DIR"/*/; do
    species=$(basename "$dir")

    echo "===================================="
    echo "Creating BLAST database for: $species"
    echo "===================================="

    cd "$dir" || continue

    if ls *.fna 1>/dev/null 2>&1; then
        makeblastdb \
            -in *.fna \
            -dbtype nucl \
            -parse_seqids \
            -out "$species"
    else
        echo "⚠️  No .fna file found in $species"
    fi
done
# Command for performing Short Blastn on the Given Species mentioned Above
# Running a single code for OutFmt-3
############################################
# PART 2: blastn-short (outfmt 3)
############################################
for dir in "$GENOMES_DIR"/*/; do
    species=$(basename "$dir")

    echo "Running blastn-short (outfmt 3) for $species"

    blastn \
      -task blastn-short \
      -query "$QUERY" \
      -db "$dir/$species" \
      -outfmt 3 \
      -evalue 0.001 \
      -dust no \
      -num_threads $THREADS \
      -out "$RESULTS_DIR/Human_vs_${species}_blastn_short.txt"
done

# Command for performing Short Blastn on the Given Species mentioned Above
# Running a single code for OutFmt-6
############################################
# PART 3: blastn-short (outfmt 6)
############################################
for dir in "$GENOMES_DIR"/*/; do
    species=$(basename "$dir")

    echo "Running blastn-short (outfmt 6) for $species"

    blastn \
      -task blastn-short \
      -query "$QUERY" \
      -db "$dir/$species" \
      -outfmt "6 qseqid sseqid pident length evalue bitscore" \
      -evalue 0.001 \
      -dust no \
      -num_threads $THREADS \
      -out "$RESULTS_DIR/Human_vs_${species}_blastn_short.tsv"
done

# Command for performing DC - Mega Blastn on the Given Species mentioned Above
# Running a single code for OutFmt-6
############################################
# PART 4: dc-megablast (outfmt 6)
############################################
for dir in "$GENOMES_DIR"/*/; do
    species=$(basename "$dir")

    echo "Running dc-megablast (outfmt 6) for $species"

    blastn \
      -task dc-megablast \
      -query "$QUERY" \
      -db "$dir/$species" \
      -outfmt "6 qseqid sseqid pident length evalue bitscore stitle" \
      -evalue 0.001 \
      -dust no \
      -num_threads $THREADS \
      -out "$RESULTS_DIR/Human_vs_${species}_dcmegablast.tsv"
done

# Command for performing DC - Mega Blastn on the Given Species mentioned Above
# Running a single code for OutFmt-3
############################################
# PART 5: dc-megablast (outfmt 3)
############################################
for dir in "$GENOMES_DIR"/*/; do
    species=$(basename "$dir")

    echo "Running dc-megablast (outfmt 3) for $species"

    blastn \
      -task dc-megablast \
      -query "$QUERY" \
      -db "$dir/$species" \
      -outfmt 3 \
      -evalue 0.001 \
      -dust no \
      -num_threads $THREADS \
      -out "$RESULTS_DIR/Human_vs_${species}_dcmegablast.txt"
done

echo "✅ PIPELINE COMPLETED SUCCESSFULLY"



# Loop command for performing Short BLAST, dc -Mega BLAST
         #outfmt 3 and outfmt 6

         #!/bin/bash

############################################
# PATHS (F12 – Hippopotamus as query)
############################################
BASE_DIR="$HOME/Dissertation"
GENOMES_DIR="$BASE_DIR/GENOMES"   # ✅ FIXED
QUERY="$BASE_DIR/GENE/F12/Hippopotamus/hippo_f12_exons.fasta"
RESULTS_DIR="$BASE_DIR/RESULTS/F12/Hippopotamus"

THREADS=8

mkdir -p "$RESULTS_DIR"

############################################
# PART 1: Create BLAST databases (if missing)
############################################
for dir in "$GENOMES_DIR"/*; do
    [ -d "$dir" ] || continue
    species=$(basename "$dir")

    echo "===================================="
    echo "Processing species: $species"
    echo "===================================="

    if [[ -f "$dir/${species}.nin" ]]; then
        echo "✅ BLAST DB already exists for $species"
    else
        if ls "$dir"/*.fna 1>/dev/null 2>&1; then
            echo "Creating BLAST DB for $species"
            makeblastdb \
              -in "$dir"/*.fna \
              -dbtype nucl \
              -parse_seqids \
              -out "$dir/$species"
        else
            echo "⚠️ No .fna file found for $species — skipping"
            continue
        fi
    fi
done

############################################
# PART 2: blastn-short (outfmt 3)
############################################
for dir in "$GENOMES_DIR"/*; do
    [ -d "$dir" ] || continue
    species=$(basename "$dir")

    blastn \
      -task blastn-short \
      -query "$QUERY" \
      -db "$dir/$species" \
      -outfmt 3 \
      -evalue 0.001 \
      -dust no \
      -num_threads $THREADS \
      -out "$RESULTS_DIR/HippoF12_vs_${species}_blastn_short.txt"
done

############################################
# PART 3: blastn-short (outfmt 6)
############################################
for dir in "$GENOMES_DIR"/*; do
    [ -d "$dir" ] || continue
    species=$(basename "$dir")

    blastn \
      -task blastn-short \
      -query "$QUERY" \
      -db "$dir/$species" \
      -outfmt "6 qseqid sseqid pident length evalue bitscore" \
      -evalue 0.001 \
      -dust no \
      -num_threads $THREADS \
      -out "$RESULTS_DIR/HippoF12_vs_${species}_blastn_short.tsv"
done

############################################
# PART 4: dc-megablast (outfmt 6)
############################################
for dir in "$GENOMES_DIR"/*; do
    [ -d "$dir" ] || continue
    species=$(basename "$dir")

    blastn \
      -task dc-megablast \
      -query "$QUERY" \
      -db "$dir/$species" \
      -outfmt "6 qseqid sseqid pident length evalue bitscore stitle" \
      -evalue 0.001 \
      -dust no \
      -num_threads $THREADS \
      -out "$RESULTS_DIR/HippoF12_vs_${species}_dcmegablast.tsv"
done

############################################
# PART 5: dc-megablast (outfmt 3)
############################################
for dir in "$GENOMES_DIR"/*; do
    [ -d "$dir" ] || continue
    species=$(basename "$dir")

    blastn \
      -task dc-megablast \
      -query "$QUERY" \
      -db "$dir/$species" \
      -outfmt 3 \
      -evalue 0.001 \
      -dust no \
      -num_threads $THREADS \
      -out "$RESULTS_DIR/HippoF12_vs_${species}_dcmegablast.txt"
done

echo "✅ F12 Hippopotamus BLAST pipeline completed successfully"
