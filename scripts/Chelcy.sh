# Downloading the genome:
# Manis javanica
 wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/040/802/235/GCF_040802235.1_MJ_LKY/GCF_040802235.1_MJ_LKY_genomic.fna.gz
 # Unziping the file:
 gunzip GCF_040802235.1_MJ_LKY_genomic.fna.gz
 # Creating the Database for Blast:
  makeblastdb \
-in GCF_040802235.1_MJ_LKY_genomic.fna \
-dbtype nucl \
-out Manis_javanica_genome

# Canis lupus
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/011/100/685/GCF_011100685.1_UU_Cfam_GSD_1.0/GCF_011100685.1_UU_Cfam_GSD_1.0_genomic.fna.gz
# Unziping the file:
gunzip 
#
