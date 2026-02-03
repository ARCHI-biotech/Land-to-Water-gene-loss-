#Retrieve human query sequences from annotation
#gene F12
efetch -db nucleotide -id NM_000505.4 -format fasta_cds_na > F12_human_CDS.fasta
#Downloading the genome assigned to me
#Sus_scrofa
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/003/025/GCA_000003025.7_T2T-Sscrofa/GCA_000003025.7_T2T-Sscrofa_genomic.fna.gz
#Command to unzip the file
gunzip GCA_000003025.7_T2T-Sscrofa_genomic.fna
#Create BLAST Database
makeblastdb \
  -in GCA_000003025.7_T2T-Sscrofa_genomic.fna \
  -dbtype nucl \
  -parse_seqids \
  -out sus_scrofa_genome_db
