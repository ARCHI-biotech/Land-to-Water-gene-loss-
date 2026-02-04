# Download Human F12 mRNA (GenBank format)
efetch -db nucleotide -id NM_000505.4 -format gb > F12.gbk
# Extract Exon Sequences from F12
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
# Running BLASTN: Human F12 Exons vs Dolphin Genome:
blastn -query F12_exons.fasta \
-db PlaMin_Genome_DB \
-out F12_vs_Platanista_pairwise.txt \
-outfmt 0 \
-evalue 1e-10 \
-max_target_seqs 3 \
-max_hsps 1

# Downloading the genome of Okapia johnstoni:
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/024/291/935/GCA_024291935.2_TBG_Okapi_asm_v1/GCA_024291935.2_TBG_Okapi_asm_v1_genomic.fna.gz
# Unziping the file:
gunzip GCA_024291935.2_TBG_Okapi_asm_v1_genomic.fna.gz
