#Retrieve human query sequences from annotation
#gene F12
efetch -db nucleotide -id NM_000505.4 -format fasta_cds_na > F12_human_CDS.fasta

#Bubalus_bubalis
weget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/019/923/935/GCF_019923935.1_NDDB_SH_1/GCF_019923935.1_NDDB_SH_1_genomic.fna.gz
#Command to unzip the file
gunzip GCF_019923935.1_NDDB_SH_1_genomic.fna.gz
#Create BLAST Database
makeblastdb -in GCF_019923935.1_NDDB_SH_1_genomic.fna -dbtype nucl -out bubalus_bubalis_db
#short blast-outfmt3 evalue0.001
blastn -task blastn-short -query query.fasta -db bubalus_bubalis_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out short_fmt3.blast
#short blast-outfmt6 evalue0.001
blastn -task blastn-short -query query.fasta -db bubalus_bubalis_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out short_fmt6.txt
 #short dc-megablast-outfmt3 evalue0.001
blastn -task dc-megablast -query query.fasta -db bubalus_bubalis_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -out dcmegablast_fmt3.blast
#short dc-megablast-outfmt6 evalue0.001
blastn -task dc-megablast -query query.fasta -db bubalus_bubalis_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -out dcmegablast_fmt6.txt


#Bison_bison
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/754/665/GCF_000754665.1_Bison_UMD1.0/GCF_000754665.1_Bison_UMD1.0_genomic.fna.gz
#Command to unzip the file
gunzip GCF_000754665.1_Bison_UMD1.0_genomic.fna.gz
#Create BLAST Database
makeblastdb -in GCF_000754665.1_Bison_UMD1.0_genomic.fna -dbtype nucl -out bison_db
#short blast-outfmt3 evalue0.001
blastn -task blastn-short -query query.fasta -db bison_bison_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out short_fmt3.blast
#short blast-outfmt6 evalue0.001
blastn -task blastn-short -query query.fasta -db bison_bison_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out short_fmt6.txt
#dc-megablast outfmt3 evalue0.001
blastn -task dc-megablast -query query.fasta -db bison_bison_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -out dcmegablast_fmt3.blast
#dc-megablast outfmt6 evalue0.001
blastn -task dc-megablast -query query.fasta -db bison_bison_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -out dcmegablast_fmt6.txt

#Physeter_macrocephalus
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/472/395/GCF_000472395.1_PhysMacro1.0/GCF_000472395.1_PhysMacro1.0_genomic.fna.gz
#Command to unzip the file
gunzip GCF_002837175.3_ASM283717v5_genomic.fna.gz
#Create BLAST Database
makeblastdb \
-in GCF_000472395.1_PhysMacro1.0_genomic.fna \
-dbtype nucl \
-parse_seqids \
-out Physeter_macrocephalus_genome_db
#short blast-outfmt3 evalue0.001
blastn -task blastn-short -query query.fasta -db Physeter_macrocephalus_genome_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out short_fmt3.blast
 #short blast-outfmt6 evalue0.001
blastn -task blastn-short -query query.fasta -db Physeter_macrocephalus_genome_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out short_fmt6.txt
 #short blast-outfmt3 evalue0.001
blastn -task dc-megablast -query query.fasta -db Physeter_macrocephalus_genome_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -out dcmegablast_fmt3.blast
 #short blast-outfmt6 evalue0.001
blastn -task dc-megablast -query query.fasta -db Physeter_macrocephalus_genome_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -out dcmegablast_fmt6.txt


 #Bos_taurus
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/002/263/795/GCF_002263795.3_ARS-UCD2.0/GCF_002263795.3_ARS-UCD2.0_cds_from_genomic.fna.gz
#Command to unzip the file
gunzip GCF_002263795.3_ARS-UCD2.0_cds_from_genomic.fna.gz
#Create BLAST Database
makeblastdb -in GCF_002263795.1_ARS-UCD1.3_genomic.fna -dbtype nucl -out bos_taurus_db
#short blast-outfmt3 evalue0.001
blastn -task blastn-short -query query.fasta -db bos_taurus_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out short_fmt3.blast
#short blast-outfmt6 evalue0.001
blastn -task blastn-short -query query.fasta -db bos_taurus_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out short_fmt6.txt
#dc-megablast outfmt3 evalue0.001
blastn -task dc-megablast -query query.fasta -db bos_taurus_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -out dcmegablast_fmt3.blast
#dc-megablast outfmt6 evalue0.001
blastn -task dc-megablast -query query.fasta -db bos_taurus_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -out dcmegablast_fmt6.txt

#Bos_indicus
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/029/378/745/GCF_029378745.1_NIAB-ARS_B.indTharparkar_mat_pri_1.0/GCF_029378745.1_NIAB-ARS_B.indTharparkar_mat_pri_1.0_genomic.fna.gz
#Command to unzip the file
gunzip GCF_029378745.1_NIAB-ARS_B.indTharparkar_mat_pri_1.0_genomic.fna.gz
#make BLAST database
makeblastdb -in GCF_029378745.1_NIAB-ARS_B.indTharparkar_mat_pri_1.0_genomic.fna -dbtype nucl -out bos_indicus_d
#short blast-outfmt3 evalue0.001
blastn -task blastn-short -query query.fasta -db bos_indicus_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out human_vs_bos_indicus_short_fmt3.blast
#short blast-outfmt6 evalue0.001
blastn -task blastn-short -query query.fasta -db bos_indicus_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out human_vs_bos_indicus_short_fmt6.txt
#dc-megablast outfmt3 evalue0.001
blastn -task dc-megablast -query query.fasta -db bos_indicus_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -out human_vs_bos_indicus_dcmegablast_fmt3.blast
#dc-megablast outfmt6 evalue0.001
blastn -task dc-megablast -query query.fasta -db bos_indicus_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -out human_vs_bos_indicus_dcmegablast_fmt6.txt

#LOOP FOR 79 GENES OF HUMAN FOR NORMAL BLAST,SHORT BLAST,DC-MEGABLAST.


#!/bin/bash

############################################
# PATHS
############################################
BASE_DIR="$HOME/Dissertation"
GENOMES_DIR="$BASE_DIR/GENOMES"
GENE_DIR="$BASE_DIR/GENE"
RESULTS_DIR="$BASE_DIR/RESULTS"
THREADS=8

############################################
# PART 0: CREATE BLAST DATABASES 
############################################
echo "=========================================="
echo "Checking / Creating BLAST Databases"
echo "=========================================="

for dir in "$GENOMES_DIR"/*/; do
    species=$(basename "$dir")

    # Find genome fasta file (.fna or .fa)
    genome_file=$(ls "$dir"/.fna 2>/dev/null || ls "$dir"/.fa 2>/dev/null)

    if [ -z "$genome_file" ]; then
        echo "⚠ No FASTA file found for $species"
        continue
    fi

    # Check if database already exists (.nsq file)
    if [ -f "$dir/$species.nsq" ]; then
        echo "✔ Database already exists for $species"
    else
        echo "Creating BLAST database for $species"

        makeblastdb \
            -in "$genome_file" \
            -dbtype nucl \
            -out "$dir/$species"
    fi
done

############################################
# LOOP THROUGH EACH GENE
############################################
for gene_folder in "$GENE_DIR"/*/; do

    gene=$(basename "$gene_folder")
    QUERY=$(ls "$gene_folder"/*_Human_exon.fasta)

    echo "=========================================="
    echo "Running full pipeline for $gene"
    echo "=========================================="

    mkdir -p "$RESULTS_DIR/$gene"

    ############################################
    # LOOP THROUGH EACH GENOME
    ############################################
    for dir in "$GENOMES_DIR"/*/; do
        species=$(basename "$dir")

        echo "Running analyses for $gene vs $species"

        ############################################
        # PART 1: blastn-short (outfmt 3)
        ############################################
        blastn \
          -task blastn-short \
          -query "$QUERY" \
          -db "$dir/$species" \
          -outfmt 3 \
          -evalue 0.001 \
          -dust no \
          -num_threads $THREADS \
          -out "$RESULTS_DIR/$gene/${gene}Human_vs${species}_blastn_short.txt"

        ############################################
        # PART 2: blastn-short (outfmt 6)
        ############################################
        blastn \
          -task blastn-short \
          -query "$QUERY" \
          -db "$dir/$species" \
          -outfmt "6 qseqid sseqid pident length evalue bitscore" \
          -evalue 0.001 \
          -dust no \
          -num_threads $THREADS \
          -out "$RESULTS_DIR/$gene/${gene}Human_vs${species}_blastn_short.tsv"

        ############################################
        # PART 3: dc-megablast (outfmt 6)
        ############################################
        blastn \
          -task dc-megablast \
          -query "$QUERY" \
          -db "$dir/$species" \
          -outfmt "6 qseqid sseqid pident length evalue bitscore stitle" \
          -evalue 0.001 \
          -dust no \
          -num_threads $THREADS \
          -out "$RESULTS_DIR/$gene/${gene}Human_vs${species}_dcmegablast.tsv"

        ############################################
        # PART 4: dc-megablast (outfmt 3)
        ############################################
        blastn \
          -task dc-megablast \
          -query "$QUERY" \
          -db "$dir/$species" \
          -outfmt 3 \
          -evalue 0.001 \
          -dust no \
          -num_threads $THREADS \
          -out "$RESULTS_DIR/$gene/${gene}Human_vs${species}_dcmegablast.txt"

        ############################################
        # PART 5: Normal blastn
        ############################################
        blastn \
          -query "$QUERY" \
          -db "$dir/$species" \
          -outfmt 3 \
          -evalue 0.001 \
          -dust no \
          -num_threads $THREADS \
          -out "$RESULTS_DIR/$gene/${gene}Human_vs${species}_blastn.txt"

    done
done

echo "✅ FULL PIPELINE COMPLETED SUCCESSFULLY"

#pipeline for extracting Hippopotamus exons 
# ---------- STEP 1: Create working directory ----------
mkdir -p ~/hippo
cd ~/hippo

# ---------- STEP 2: Download hippo genome ----------
wget -c https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/030/028/045/GCF_030028045.1_mHipAmp2/GCF_030028045.1_mHipAmp2.hap2_genomic.fna.gz

# ---------- STEP 3: Unzip genome ----------
gunzip GCF_030028045.1_mHipAmp2.hap2_genomic.fna.gz

# ---------- STEP 4: Make BLAST database ----------
makeblastdb -in GCF_030028045.1_mHipAmp2.hap2_genomic.fna \
-dbtype nucl \
-parse_seqids \
-out hippo_db

# ---------- STEP 5: Place human exon file ----------
# Copy your exon file into this folder if needed
# cp /path/to/PAPL_Human_exon.fasta ~/hippo/

# ---------- STEP 6: Run BLAST ----------
blastn -task blastn-short \
-query PAPL_Human_exon.fasta \
-db hippo_db \
-out PAPL_vs_hippo.tsv \
-outfmt 6 \
-evalue 1e-5

# ---------- STEP 7: Convert hits ----------
awk '{if ($9<$10) print $2"\t"$9"\t"$10; else print $2"\t"$10"\t"$9}' \
PAPL_vs_hippo.tsv > PAPL_hits.bed

# ---------- STEP 8: Sort hits ----------
sort -k1,1 -k2,2n PAPL_hits.bed > PAPL_sorted.bed

# ---------- STEP 9: Merge overlaps ----------
bedtools merge -i PAPL_sorted.bed > PAPL_merged.bed

# ---------- STEP 10: Convert coordinates ----------
awk '{print $1":"$2+1"-"$3}' \
PAPL_merged.bed > hippo_PAPL_exons.coords

# ---------- STEP 11: Extract exons ----------
samtools faidx GCF_030028045.1_mHipAmp2.hap2_genomic.fna \
-r hippo_PAPL_exons.coords \
> hippo_PAPL_exons_raw.fasta

# ---------- STEP 12: Format like human exon file ----------
awk '/^>/{print ">exon_"++i; next} {print}' \
hippo_PAPL_exons_raw.fasta > PAPL_Hippo_exons.fasta

# ---------- STEP 13: Check result ----------
grep ">" PAPL_Hippo_exons.fasta


