 #Retrieve human query sequences from annotation
#gene F12
efetch -db nucleotide -id NM_000505.4 -format fasta_cds_na > F12_human_CDS.fasta
# Balaenoptera_acutorostrata [minke_whale]
#Downloading the genome
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/949/987/535/GCF_949987535.1_mBalAcu1.1/GCF_949987535.1_mBalAcu1.1_genomic.fna.gz
gunzip GCF_949987535.1_mBalAcu1.1_genomic.fna.gz
# Create BLAST database
makeblastdb -in GCF_949987535.1_mBalAcu1.1_genomic.fna -dbtype nucl -out balaenoptera_db
#Sort blast command with outfmt 3,6
blastn -task blastn-short -query query.fasta -db balaenoptera_db -outfmt 3 -evalue 0.001 -dust no -num_threads 8 -out query_vs_whale_shortblast.txt
blastn -task blastn-short -query query.fasta -db balaenoptera_db -outfmt 6 -evalue 0.001 -dust no -num_threads 8 -out query_vs_whale_shortblast.txt
#Dc-mega blast command with outfmt 3,6
blastn -query query.fasta -db balaenoptera_db -out query_vs_whale_dcmegablast.txt -outfmt 3 -task dc-megablast
blastn -query query.fasta -db balaenoptera_db -out query_vs_whale_dcmegablast.txt -outfmt 6 -task dc-megablast

#Cervu_candensis
#Downloading the genome
#wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/019/320/065/GCF_019320065.1_ASM1932006v1/GCF_019320065.1_ASM1932006v1_genomic.fna.gz
# Create BLAST database
makeblastdb -in GCF_019320065.1_ASM1932006v1_genomic.fna -dbtype nucl -out cervus_db

#Hydropotes_inermis
#Downloading the genome
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/020/226/075/GCA_020226075.1_ASM2022607v1/GCA_020226075.1_ASM2022607v1_genomic.fna.gz
# Create BLAST database
makeblastdb -in GCA_020226075.1_ASM2022607v1_genomic.fna -dbtype nucl -out Hydropotes_db

#Odocoileus_virginianus
#Downloading the genome
weget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/023/699/985/GCF_023699985.2_Ovbor_1.2/GCF_023699985.2_Ovbor_1.2_genomic.fna.gz
# Create BLAST database
makeblastdb -in GCF_023699985.2_Ovbor_1.2_genomic.fna -dbtype nucl -out Odocoileus_db

#Capra_hircus
#Downloading the genome
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/001/704/415/GCF_001704415.2_ARS1.2/GCF_001704415.2_ARS1.2_genomic.fna.g
# Create BLAST database
makeblastdb -in Capra_hircus/*.fna -dbtype nucl -parse_seqids -out Capra_hircus/Capra_hircus

#Ovis_aries
#Downloading the genome
#wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/016/772/045/GCF_016772045.2_ARS-UI_Ramb_v3.0/GCF_016772045.2_ARS-UI_Ramb_v3.0_genomic.fna.g
# Create BLAST database
makeblastdb -in GCF_016772045.2_ARS-UI_Ramb_v3.0_genomic.fna -dbtype nucl -out Ovis_db

############################################
# PATHS
############################################
BASE_DIR="$HOME/Dissertation"
GENOMES_DIR="$BASE_DIR/GENOMES"
GENE_DIR="$BASE_DIR/GENE"
RESULTS_DIR="$BASE_DIR/RESULTS"
QUERY="$GENE_DIR/query.fasta"
THREADS=8
mkdir -p "$RESULTS_DIR"

# Command for performing Short Blastn on the Given Species mentioned Above
# Running a single code
# OutFmt-3
QUERY="/home/arijit/Archi/GENE/F12_Query(Human).fasta"

for dir in */; do
    # Skip GENE folder
    if [ "$dir" = "GENE/" ]; then
        continue
    fi

    species=$(basename "$dir")

    echo "=============================================="
    echo "Running genome BLAST (blastn-short) for $species"
    echo "=============================================="

    cd "$dir" || continue

    blastn \
      -task blastn-short \
      -query "$QUERY" \
      -db "$species" \
      -outfmt 3 \
      -evalue 0.001 \
      -dust no \
      -num_threads 8 \
      -out "Human_F12_vs_${species}.blast"

    cd ..
done
# Command for performing Short Blastn on the Given Species mentioned Above
# Running a single code
# OutFmt-6
QUERY="/home/arijit/Archi/GENE/F12_Query(Human).fasta"

for dir in */; do
    # Skip GENE folder
    if [ "$dir" = "GENE/" ]; then
        continue
    fi

    species=$(basename "$dir")

    echo "=============================================="
    echo "Running genome BLAST (blastn-short) for $species"
    echo "=============================================="

    cd "$dir" || continue

    blastn \
      -task blastn-short \
      -query "$QUERY" \
      -db "$species" \
      -outfmt 6 \
      -evalue 0.001 \
      -dust no \
      -num_threads 8 \
      -out "Human_F12_vs_${species}_pairwise.blast"

    cd ..
done
