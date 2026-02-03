#Retrieve human query sequences from annotation
#gene F12
efetch -db nucleotide -id NM_000505.4 -format fasta_cds_na > F12_human_CDS.fasta
Downloading the genome -
# Erinaceus europaeus
# Download hedgehog genome
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/950/295/315/GCF_950295315.1_mEriEur2.1/GCF_950295315.1_mEriEur2.1_genomic.fna.gz
# Unzip genome
gunzip GCF_950295315.1_mEriEur2.1_genomic.fna.gz
# Create BLAST database
makeblastdb -in GCF_950295315.1_mEriEur2.1_genomic.fna -dbtype nucl -parse_seqids -out hedgehog_db

