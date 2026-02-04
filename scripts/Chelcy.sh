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
