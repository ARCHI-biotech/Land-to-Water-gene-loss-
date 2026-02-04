
#Retrieve human query sequences from annotation
#gene F12
esearch -db nuccore -query "NM_000505.5" | efetch -format fasta_cds_na > F12_CDS.fasta

#Downloading the genome assigned to me
#Trichechus_manatus
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/243/295/GCF_000243295.1_TriManLat1.0/GCF_000243295.1_TriManLat1.0_genomic.fna.gz
#Command to unzip the file
gunzip GCF_000243295.1_TriManLat1.0_genomic.fna.gz
#Create BLAST Database
makeblastdb -in GCF_000243295.1_TriManLat1.0_genomic.fna -dbtype nucl -out manatee_db


#Downloading the genome assigned to me
#Loxodonta_africana
 wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/030/014/295/GCF_030014295.1_mLoxAfr1.hap2/GCF_030014295.1_mLoxAfr1.hap2_cds_from_genomic.fna.gz
#Command to unzip the file
gunzip GCF_030014295.1_mLoxAfr1.hap2_cds_from_genomic.fna.gz
#Create BLAST Database
makeblastdb -in GCF_030014295.1_mLoxAfr1.hap2_cds_from_genomic.fna -dbtype nucl -out elephant_cds_db

Physeter_macrocephalus
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/472/395/GCF_000472395.1_PhysMacro1.0/GCF_000472395.1_PhysMacro1.0_genomic.fna.gz
#Command to unzip the file
gunzip GCF_002837175.3_ASM283717v5_genomic.fna.gz
makeblastdb \
  -in GCF_000472395.1_PhysMacro1.0_genomic.fna \
  -dbtype nucl \
  -parse_seqids \
  -out Physeter_macrocephalus_genome_db
