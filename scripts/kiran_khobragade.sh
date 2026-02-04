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
#Downloaded the genome assigned to me
#Hippopotamus_amphibius
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/030/028/045/GCF_030028045.1_mHipAmp2.hap2/GCF_030028045.1_mHipAmp2.hap2_genomic.fna.gz
#Command for unzip the file
gunzip GCF_030028045.1_mHipAmp2.hap2_genomic.fna.gz
#Create BLAST Database
 makeblastdb \
-in GCF_030028045.1_mHipAmp2.hap2_genomic.fna \
-dbtype nucl \
-parse_seqids \
-out Hippo_hap2_genome_db
#Downloaded the genome assigned to me
#Eubalaena_japonica
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/004/363/455/GCA_004363455.1_EubJap_v1_BIUU/GCA_004363455.1_EubJap_v1_BIUU_genomic.fna.gz
#Command to unzip the file
gunzip GCA_004363455.1_EubJap_v1_BIUU_genomic.fna.gz
#Create BLAST Database
makeblastdb \
-in GCA_004363455.1_EubJap_v1_BIUU_genomic.fna \
-dbtype nucl \
-parse_seqids \
-out Eubalaena_japonica_genome_db
#Downloaded the genome assigned to me
#Budorcas_taxicolor
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/023/091/745/GCF_023091745.1_Takin1.1/GCF_023091745.1_Takin1.1_genomic.fna.gz
#Command for unzip the file
gunzip GCF_023091745.1_Takin1.1_genomic.fna.gz
#Create BLAST Database
makeblastdb \
-in GCF_023091745.1_Takin1.1_genomic.fna \
-dbtype nucl \
-parse_seqids \
-out Budorcas_taxicolor_genome_db
#Downloaded the genome assigned to me
#Balaenoptera_musculus
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/009/873/245/GCF_009873245.2_mBalMus1.pri.v3/GCF_009873245.2_mBalMus1.pri.v3_genomic.fna.gz
#Command for unzip the file
gunzip GCF_009873245.2_mValMus1.pri.v3_genomic.fna.gz
#Create BLAST Database
makeblastdb \
-in GCF_009873245.2_mValMus1.pri.v3_genomic.fna \
-dbtype nucl \
-parse_seqids \
-out Balaenoptera_musculus_genome_db
#Downloaded the genome assigned to me
#Camelus_bactrianus
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/048/773/025/GCF_048773025.1_ASM4877302v1/GCF_048773025.1_ASM4877302v1_genomic.fna.gz
#Command for unzip the file
gunzip GCF_048773025.1_ASM4877302v1_genomic.fna.gz
#Create BLAST Database
makeblastdb \
-in GCF_048773025.1_ASM4877302v1_genomic.fna \
-dbtype nucl \
-parse_seqids \
-out Camelus_bactrianus_genome_db
