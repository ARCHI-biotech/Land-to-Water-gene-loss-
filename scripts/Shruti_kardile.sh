#Retrieve human query sequences from annotation
#gene F12
efetch -db nucleotide -id NM_000505.4 -format fasta_cds_na > F12_human_CDS.fasta
#Downloading the genome assigned to me
#Giraffa_camelopardalis
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/017/591/445/GCA_017591445.1_ASM1759144v1/GCA_017591445.1_ASM1759144v1_genomic.fna.gz
