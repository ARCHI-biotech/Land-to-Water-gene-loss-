#Retrieve human query sequences from annotation
#gene F12
esearch -db nuccore -query "NM_000505.5" | efetch -format fasta_cds_na > F12_CDS.fasta
#Downloading the genome assigned to me
#Trichechus_manatus
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/030/014/295/GCF_030014295.1_mLoxAfr1.hap2/GCF_030014295.1_mLoxAfr1.hap2_cds_from_genomic.fna.gz
#Command to unzip the file
gunzip GCF_000243295.1_TriManLat1.0_genomic.fna.gz
#Create BLAST Database
makeblastdb -in GCF_000243295.1_TriManLat1.0_genomic.fna -dbtype nucl -out manatee_db
