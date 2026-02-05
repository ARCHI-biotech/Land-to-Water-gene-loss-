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
# Forloop command for dc-megablast (HumanF12 vs Species) 
QUERY="/home/arijit/kiran/query.fasta"
BASE_DIR="/home/arijit/kiran"

for species in \
  Balaenoptera_musculus \
  Budorcas_taxicolor \
  Camelus_bactrianus \
  Eubalaena_japonica \
  Hippo_hap2 \
  sus_scrofa
do
    echo "=============================================="
    echo "Running DC-MEGABLAST (outfmt 6) for $species"
    echo "=============================================="

    cd "$BASE_DIR/$species" || continue

    blastn \
      -task dc-megablast \
      -query "$QUERY" \
      -db "${species}_genome_db" \
      -evalue 0.001 \
      -dust no \
      -num_threads 8 \
      -outfmt 6 \
      -out "Human_F12_vs_${species}.tsv"

    cd "$BASE_DIR"
done
#Forloop command for short blastn (HumanF12 vs Species)
QUERY="/home/arijit/kiran/query.fasta"
BASE_DIR="/home/arijit/kiran"

for species in \
  Balaenoptera_musculus \
  Budorcas_taxicolor \
  Camelus_bactrianus \
  Eubalaena_japonica \
  Hippo_hap2 \
  sus_scrofa
do
    echo "=============================================="
    echo "Running genome BLAST for $species"
    echo "=============================================="

    cd "$BASE_DIR/$species" || continue

    blastn \
      -task blastn \
      -query "$QUERY" \
      -db "${species}_genome_db" \
      -evalue 0.001 \
      -dust no \
      -num_threads 8 \
      -outfmt 3 \
      -out "Human_F12_vs_${species}_query_anchored.blast"

    cd "$BASE_DIR"
done
#Forloop command for blastn (HippopotamusF12 vs Species) 
# Path to your query FASTA (single file)
QUERY="/home/arijit/kiran/Hippopotamus_query.fasta"
BASE_DIR="/home/arijit/kiran"

# List of species to run genome BLAST against
for species in \
  Balaenoptera_musculus \
  Budorcas_taxicolor \
  Camelus_bactrianus \
  Eubalaena_japonica \
  Hippo_hap2 \
  sus_scrofa
do
    echo "=============================================="
    echo "Running genome BLAST for $species"
    echo "=============================================="

    # Go to species folder
    cd "$BASE_DIR/$species" || { echo "Folder $BASE_DIR/$species not found, skipping"; continue; }

    # Run blastn in query-anchored human-readable format
    blastn \
      -task blastn \
      -query "$QUERY" \
      -db "${species}_genome_db" \
      -evalue 0.001 \
      -dust no \
      -num_threads 8 \
      -outfmt 3 \
      -out "Hippof12_vs_${species}.blast"

    # Return to base directory
    cd "$BASE_DIR"
done

