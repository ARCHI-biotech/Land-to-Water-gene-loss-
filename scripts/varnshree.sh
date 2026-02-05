#Bubalus_bubalis
weget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/019/923/935/GCF_019923935.1_NDDB_SH_1/GCF_019923935.1_NDDB_SH_1_genomic.fna.gz
#Command to unzip the file
gunzip GCF_019923935.1_NDDB_SH_1_genomic.fna.gz
#Create BLAST Database
makeblastdb -in GCF_019923935.1_NDDB_SH_1_genomic.fna -dbtype nucl -out bubalus_bubalis_db
#short blast-outfmt3 evalue0.001
blastn -task blastn-short -query query.fasta -db bubalus_bubalis_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out short_fmt3.blast
#short blast-outfmt6 evalue0.001
blastn -task blastn-short -query query.fasta -db bubalus_bubalis_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out short_fmt6.txt
 #short dc-megablast-outfmt3 evalue0.001
blastn -task dc-megablast -query query.fasta -db bubalus_bubalis_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -out dcmegablast_fmt3.blast
#short dc-megablast-outfmt6 evalue0.001
blastn -task dc-megablast -query query.fasta -db bubalus_bubalis_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -out dcmegablast_fmt6.txt


#Bison_bison
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/754/665/GCF_000754665.1_Bison_UMD1.0/GCF_000754665.1_Bison_UMD1.0_genomic.fna.gz
 #Command to unzip the file
 gunzip GCF_000754665.1_Bison_UMD1.0_genomic.fna.gz
 #Create BLAST Database
  makeblastdb -in GCF_000754665.1_Bison_UMD1.0_genomic.fna -dbtype nucl -out bison_db
#short blast-outfmt3 evalue0.001
blastn -task blastn-short -query query.fasta -db bison_bison_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out short_fmt3.blast
#short blast-outfmt6 evalue0.001
blastn -task blastn-short -query query.fasta -db bison_bison_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out short_fmt6.txt
#dc-megablast outfmt3 evalue0.001
blastn -task dc-megablast -query query.fasta -db bison_bison_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -out dcmegablast_fmt3.blast
#dc-megablast outfmt6 evalue0.001
blastn -task dc-megablast -query query.fasta -db bison_bison_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -out dcmegablast_fmt6.txt

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
  #short blast-outfmt3 evalue0.001
blastn -task blastn-short -query query.fasta -db Physeter_macrocephalus_genome_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out short_fmt3.blast
 #short blast-outfmt6 evalue0.001
blastn -task blastn-short -query query.fasta -db Physeter_macrocephalus_genome_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out short_fmt6.txt
 #short blast-outfmt3 evalue0.001
blastn -task dc-megablast -query query.fasta -db Physeter_macrocephalus_genome_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -out dcmegablast_fmt3.blast
 #short blast-outfmt6 evalue0.001
blastn -task dc-megablast -query query.fasta -db Physeter_macrocephalus_genome_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -out dcmegablast_fmt6.txt


 #Bos_taurus
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/002/263/795/GCF_002263795.3_ARS-UCD2.0/GCF_002263795.3_ARS-UCD2.0_cds_from_genomic.fna.gz
#Command to unzip the file
gunzip GCF_002263795.3_ARS-UCD2.0_cds_from_genomic.fna.gz
#Create BLAST Database
makeblastdb -in GCF_002263795.1_ARS-UCD1.3_genomic.fna -dbtype nucl -out bos_taurus_db
#short blast-outfmt3 evalue0.001
blastn -task blastn-short -query query.fasta -db bos_taurus_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out short_fmt3.blast
#short blast-outfmt6 evalue0.001
blastn -task blastn-short -query query.fasta -db bos_taurus_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out short_fmt6.txt
#dc-megablast outfmt3 evalue0.001
blastn -task dc-megablast -query query.fasta -db bos_taurus_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -out dcmegablast_fmt3.blast
#dc-megablast outfmt6 evalue0.001
blastn -task dc-megablast -query query.fasta -db bos_taurus_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -out dcmegablast_fmt6.txt

#Bos_indicus
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/029/378/745/GCF_029378745.1_NIAB-ARS_B.indTharparkar_mat_pri_1.0/GCF_029378745.1_NIAB-ARS_B.indTharparkar_mat_pri_1.0_genomic.fna.gz
#Command to unzip the file
gunzip GCF_029378745.1_NIAB-ARS_B.indTharparkar_mat_pri_1.0_genomic.fna.gz
#make BLAST database
makeblastdb -in GCF_029378745.1_NIAB-ARS_B.indTharparkar_mat_pri_1.0_genomic.fna -dbtype nucl -out bos_indicus_d
#short blast-outfmt3 evalue0.001
blastn -task blastn-short -query query.fasta -db bos_indicus_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out human_vs_bos_indicus_short_fmt3.blast
#short blast-outfmt6 evalue0.001
blastn -task blastn-short -query query.fasta -db bos_indicus_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -max_target_seqs 10 -out human_vs_bos_indicus_short_fmt6.txt
#dc-megablast outfmt3 evalue0.001
blastn -task dc-megablast -query query.fasta -db bos_indicus_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -out human_vs_bos_indicus_dcmegablast_fmt3.blast
#dc-megablast outfmt6 evalue0.001
blastn -task dc-megablast -query query.fasta -db bos_indicus_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -out human_vs_bos_indicus_dcmegablast_fmt6.txt


