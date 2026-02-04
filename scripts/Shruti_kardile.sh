#Retrieve human query sequences from annotation
#gene F12
efetch -db nucleotide -id NM_000505.4 -format fasta_cds_na > F12_human_CDS.fasta
#Downloading the genome assigned to me
#Megaptera_novaeangliae
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/041/834/305/GCA_041834305.1_ASM4183430v1/GCA_041834305.1_ASM4183430v1_genomic.fna.gz
#Command to unzip the file
gunzip GCA_041834305.1_ASM4183430v1_genomic.fna.gz
#Create BLAST Database
makeblastdb \
  -in GCA_041834305.1_ASM4183430v1_genomic.fna \
  -dbtype nucl \
  -parse_seqids \
  -out Megaptera_novaeangliae_genome_db
#Downloaded the genome assigned to me
#Eschrichtius_robustus
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/028/021/215/GCF_028021215.1_mEscRob2.pri/GCF_028021215.1_mEscRob2.pri_genomic.gbff.gz
#Command to unzip the file
gunzip GCF_028021215.1_mEscRob2.pri_genomic.fna.gz
#Create BLAST Database
makeblastdb \
  -in GCF_028021215.1_mEscRob2.pri_genomic.fna \
  -dbtype nucl \
  -parse_seqids \
  -out Eschrichtius_robustus_genome_db
  #Downloaded the genome assigned to me
  #Kogia_breviceps
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/026/419/965/GCF_026419965.1_mKogBre1_haplotype_1/GCF_026419965.1_mKogBre1_haplotype_1_genomic.fna.gz
#Command to unzip the file
gunzip GCF_026419965.1_mKogBre1_haplotype_1_genomic.fna.gz
#Create BLAST Database
makeblastdb \
  -in GCF_026419965.1_mKogBre1_haplotype_1_genomic.fna \
  -dbtype nucl \
  -parse_seqids \
  -out Kogia_breviceps_genome_db
  #Downloaded the genome assigned to me
  #Physeter_catodon
