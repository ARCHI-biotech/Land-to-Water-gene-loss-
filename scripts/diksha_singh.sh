 # Retrieve human query sequences from annotation
# gene F12:
efetch -db nucleotide -id NM_000505.4 -format fasta_cds_na > F12_human_CDS.fasta
# Downloading the genome:
orcinus orca
 wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/937/001/465/GCF_937001465.1_mOrcOrc1.1/GCF_937001465.1_mOrcOrc1.1          _genomic.fna.gz
#gungip 
gunzip GCF_937001465.1_mOrcOrc1.1_genomic.fna.gz
#create blast database
makeblastdb \
-in GCF_937001465.1_mOrcOrc1.1_genomic.fna \
-dbtype nucl \
-out orca_db

Neophocaena asiaeeorientalis
wger https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/003/031/525/GCF_003031525.2_Neophocaena_asiaeorientalis_V1.1/GCF_003031525.2_Neophocaena_asiaeorientalis_V1.1_genomic.fna.gz
#gunzip
gunzip GCF_003031525.2_Neophocaena_asiaeorientalis_V1.1_genomic.fna.gz
#create database
makeblastdb -in GCF_003031525.2_Neophocaena_asiaeorientalis_V1.1_genomic.fna -dbtype nucl -out porpoise_db

Phocoena sinus
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/008/692/025/GCF_008692025.1_mPhoSin1.pri/GCF_008692025.1_mPhoSin1.pri_genomic.fna.gz
#gunzip
gunzip GCF_008692025.1_mPhoSin1.pri_genomic.fna.gz
#create database
makeblastdb -in GCF_008692025.1_mPhoSin1.pri_genomic.fna -dbtype nucl -out phocoena_db

Lagenorhynchus obliquidens
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/003/676/395/GCF_003676395.1_ASM367639v1/GCF_003676395.1_ASM367639v1_genomic.fna.gz
#gunzip
gunzip GCF_003676395.1_ASM367639v1_genomic.fna.gz
#create database
makeblastdb -in GCF_003676395.1_ASM367639v1_genomic.fna -dbtype nucl -out lageno_db

Globicephla melas
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/963/455/315/GCF_963455315.2_mGloMel1.2/GCF_963455315.2_mGloMel1.2_genomic.fna.gz
#gunzip
gunzip GCF_963455315.2_mGloMel1.2_genomic.fna.gz
#create databse
 makeblastdb -in GCF_963455315.2_mGloMel1.2_genomic.fna -dbtype nucl -out glo_db

Muntiacus muntjac
https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/008/782/695/GCA_008782695.1_UCB_Mmun_1.0/GCA_008782695.1_UCB_Mmun_1.0_genomic.fna.gz
#gunzip
 GCA_008782695.1_UCB_Mmun_1.0_genomic.fna.gz
 #create database
makeblastdb -in GCA_008782695.1_UCB_Mmun_1.0_genomic.fna -dbtype nucl -out glo_db

