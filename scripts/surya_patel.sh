# Balaenoptera_acutorostrata [minke_whale]
#Downloading the genome
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/949/987/535/GCF_949987535.1_mBalAcu1.1/GCF_949987535.1_mBalAcu1.1_genomic.fna.gz
gunzip GCF_949987535.1_mBalAcu1.1_genomic.fna.gz
# Create BLAST database
makeblastdb -in GCF_949987535.1_mBalAcu1.1_genomic.fna -dbtype nucl -out balaenoptera_db




