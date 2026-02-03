#Retrieve human query sequences from annotation
#gene F12
efetch -db nucleotide -id NM_000505.4 -format fasta_cds_na > F12_human_CDS.fasta

# Erinaceus_europaeus
#Downloading the genome
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/950/295/315/GCF_950295315.1_mEriEur2.1/GCF_950295315.1_mEriEur2.1_genomic.fna.gz
# Unzip genome
gunzip GCF_950295315.1_mEriEur2.1_genomic.fna.gz
# Create BLAST database
makeblastdb -in GCF_950295315.1_mEriEur2.1_genomic.fna -dbtype nucl -parse_seqids -out hedgehog_db

#Oryctolagus_cuniculus
# Downloading the genome
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/964/237/555/GCF_964237555.1_mOryCun1.1/GCF_964237555.1_mOryCun1.1_genomic.fna.gz
# Unzip genome
gunzip GCF_964237555.1_mOryCun1.1_genomic.fna.gz
# Create BLAST database
makeblastdb -in GCF_964237555.1_mOryCun1.1_genomic.fna -dbtype nucl -parse_seqids -out rabbit_db


