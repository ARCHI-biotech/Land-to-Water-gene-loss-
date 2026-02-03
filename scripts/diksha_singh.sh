 # Retrieve human query sequences from annotation
# gene F12:
efetch -db nucleotide -id NM_000505.4 -format fasta_cds_na > F12_human_CDS.fasta
# Downloading the genome:
# Bos indicus
 wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/029/378/745/GCF_029378745.1_NIAB-ARS_B.indTharparkar_mat_pri_1.0/GCF_029378745.1_NIAB-ARS_B.indTharparkar_mat_pri_1.0_genomic.fna.gz
 # Unziping the file:
 gunzip GCF_029378745.1_NIAB-ARS_B.indTharparkar_mat_pri_1.0_genomic.fna.gz
 # Creating the Database for Blast:
  makeblastdb -in GCF_029378745.1_NIAB-ARS_B.indTharparkar_mat_pri_1.0_genomic.fna -dbtype nucl -out Bos_indicus_genome
