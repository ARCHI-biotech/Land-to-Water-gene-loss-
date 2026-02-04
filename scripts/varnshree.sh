#Bubalus_bubalis
weget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/019/923/935/GCF_019923935.1_NDDB_SH_1/GCF_019923935.1_NDDB_SH_1_genomic.fna.gz
#Command to unzip the file
gunzip GCF_019923935.1_NDDB_SH_1_genomic.fna.gz
#Create BLAST Database
makeblastdb -in GCF_019923935.1_NDDB_SH_1_genomic.fna -dbtype nucl -out bubalus_bubalis_db

  #Bison_bison
  wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/754/665/GCF_000754665.1_Bison_UMD1.0/GCF_000754665.1_Bison_UMD1.0_genomic.fna.gz
  #Command to unzip the file
   gunzip GCF_000754665.1_Bison_UMD1.0_genomic.fna.gz
   #Create BLAST Database
    makeblastdb -in GCF_000754665.1_Bison_UMD1.0_genomic.fna -dbtype nucl -out bison_db

    #Physeter_macrocephalus
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/472/395/GCF_000472395.1_PhysMacro1.0/GCF_000472395.1_PhysMacro1.0_genomic.fna.gz
#Command to unzip the file
gunzip GCF_002837175.3_ASM283717v5_genomic.fna.gz
#Create BLAST Database
makeblastdb \
  -in GCF_000472395.1_PhysMacro1.0_genomic.fna \
  -dbtype nucl \
  -parse_seqids \
  -out Physeter_macrocephalus_genome_db
