#Retrieve human query sequences from annotation
#gene F12
efetch -db nucleotide -id NM_000505.4 -format fasta_cds_na > F12_Human_CDS.fasta
#Downloading the genomes assigned to me
#Budorcas_taxicolor
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/023/091/745/GCF_023091745.1_Takin1.1/GCF_023091745.1_Takin1.1_genomic.fna.gz
#Command to unzip the file
gunzip GCF_023091745.1_Takin1.1_genomic.fna.gz
#Create BLAST Database
makeblastdb \
-in GCF_023091745.1_Takin1.1_genomic.fna \
-dbtype nucl \
 -parse_seqids \
-out Budorcas_taxicolor_genome_db
