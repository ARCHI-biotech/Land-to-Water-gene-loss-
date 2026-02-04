#Retrieve human query sequences from annotation
#gene F12
efetch -db nucleotide -id NM_000505.4 -format fasta_cds_na > F12_Human_CDS.fasta
#Downloading the genomes assigned to me
#Hyperoodon ampullatus
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/949/752/795/GCA_949752795.1_mHypAmp2.1/GCA_949752795.1_mHypAmp2.1_genomic.fna.gz
#Command to unzip the file
gunzip GCA_949752795.1_mHypAmp2.1_genomic.fna.gz
#Mesoplodon densirostris
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/025/265/405/GCF_025265405.1_mMesDen1_primary_haplotype/GCF_025265405.1_mMesDen1_primary_haplotype_genomic.fna.gz
#Command to unzip the file
 gunzip GCF_025265405.1_mMesDen1_primary_haplotype_genomic.fna.gz
#Pontoporia blainvillei
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/011/754/075/GCA_011754075.1_ASM1175407v1/GCA_011754075.1_ASM1175407v1_genomic.fna.gz
#Command to unzip the file
gunzip GCA_011754075.1_ASM1175407v1_genomic.fna.gz
#Lipotes Vexillifer
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/442/215/GCF_000442215.2_Lipotes_vexillifer_v1.1/GCF_000442215.2_Lipotes_vexillifer_v1.1_genomic.fna.gz
#Command to unzip the file
 gunzip GCF_000442215.2_Lipotes_vexillifer_v1.1_genomic.fna.gz
 #Delphinapterus leucas
 wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/002/288/925/GCF_002288925.2_ASM228892v3/GCF_002288925.2_ASM228892v3_genomic.fna.gz
 #Command to unzip the file
 GCF_002288925.2_ASM228892v3_genomic.fna.gz
 #Monodon monoceros
 wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/005/190/385/GCA_005190385.3_NGI_Narwhal_2/GCA_005190385.3_NGI_Narwhal_2_genomic.fna.gz
  #Command to unzip the file
   gunzip GCA_005190385.3_NGI_Narwhal_2_genomic.fna.gz
   # For Creation Of Database For Each Species mentioned above
   # By running a single command 
   for dir in */; do
    species=$(basename "$dir")

    echo "===================================="
    echo "Creating BLAST database for: $species"
    echo "===================================="

    cd "$dir" || continue

    if ls *.fna 1>/dev/null 2>&1; then
        makeblastdb \
            -in *.fna \
            -dbtype nucl \
            -parse_seqids \
            -out "$species"
    else
        echo "No .fna file found in $species"
    fi

    cd ..
done
# Command for performing Short Blastn on the Given Species mentioned Above
# Running a single code
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
