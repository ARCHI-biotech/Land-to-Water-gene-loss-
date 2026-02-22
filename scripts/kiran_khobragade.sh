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
#Genome BLAST Automation Pipeline for Multi-Species Gene Analysis
#For human query for 80 genes
#!/bin/bash

# ==============================
# PATHS
# ==============================
BASE_DIR="/home/arijit/kiran"
QUERY_DIR="$BASE_DIR/GENES (human)"

# ==============================
# SPECIES
# ==============================
species_list=(
sus_scrofa
Hippo_hap2
Eubalaena_japonica
Camelus_bactrianus
Budorcas_taxicolor
Balaenoptera_musculus
)

# ==============================
# MAIN LOOP
# ==============================
for species in "${species_list[@]}"; do

    echo "===================================="
    echo "Running BLAST for $species"
    echo "===================================="

    # your real blast database name
    db="$BASE_DIR/$species/${species}_genome_db"

    # ALL FILES inside GENES (human)
    for query in "$QUERY_DIR"/*; do

        [ -f "$query" ] || continue

        filename=$(basename "$query")

        # 🔥 GENE NAME = FIRST PART BEFORE "_"
        gene=$(echo "$filename" | cut -d'_' -f1)

        result_dir="$BASE_DIR/$species/HUMAN_Results/$gene"
        mkdir -p "$result_dir"

        echo "→ $filename  vs  $species"

        # 1️⃣ NORMAL GENOME BLAST
        blastn \
            -query "$query" \
            -db "$db" \
            -out "$result_dir/${gene}_blast.blast" \
            -outfmt 3 \
            -evalue 0.001 \
            -dust no \
            -num_threads 8

        # 2️⃣ SHORT BLAST
        blastn \
            -task blastn-short \
            -query "$query" \
            -db "$db" \
            -out "$result_dir/${gene}_short.blast" \
            -outfmt 3 \
            -evalue 0.001 \
            -dust no \
            -num_threads 8

        # 3️⃣ DC-MEGABLAST
        blastn \
            -task dc-megablast \
            -query "$query" \
            -db "$db" \
            -out "$result_dir/${gene}_dcmegablast.blast" \
            -outfmt 3 \
            -evalue 0.001 \
            -dust no \
            -num_threads 8

    done
done

echo "✅ ALL BLAST RUNS COMPLETED."
#Forloop command for running blast human CDS against species
#!/bin/bash

species_list=(
"sus_scrofa"
"Hippo_hap2"
"Eubalaena_japonica"
"Camelus_bactrianus"
"Budorcas_taxicolor"
"Balaenoptera_musculus"
)

for query in Human_CDS/*.fasta
do
    filename=$(basename "$query")
    gene=${filename%%_*}

    echo "Processing gene: $gene"

    for sp in "${species_list[@]}"
    do
        db="$sp/${sp}_genome_db"
        result_dir="$sp/HUMAN_Results/$gene"

        echo "  Running BLAST against $sp"

        blastn \
            -query "$query" \
            -db "$db" \
            -out "$result_dir/${gene}_CDS_blast.blast" \
            -outfmt 3 \
            -evalue 0.001 \
            -dust no \
            -num_threads 8
    done
done

echo "All BLAST runs completed successfully!"
# Command for making word file
python3 - << 'EOF'
import os
from docx import Document
from docx.shared import Pt, RGBColor
from docx.enum.section import WD_ORIENT
from docx.enum.text import WD_COLOR_INDEX

# ==========================
# BASE DIRECTORY
# ==========================
BASE_DIR = "/home/arijit/kiran"

# Ignore these folders at base level
IGNORE = {
    "Human_CDS",
    "Hippo_CDS",
    "GENES_hippo",
    "GENES_human",
}

# ==========================
# FUNCTION: Detect Indels
# ==========================
def detect_indels(query_seq, subject_seq):
    insertions = 0
    deletions = 0

    for q, s in zip(query_seq, subject_seq):
        # Query has '-' → insertion in subject
        if q == "-" and s != "-":
            insertions += 1
        # Subject has '-' → deletion in subject
        elif s == "-" and q != "-":
            deletions += 1

    comments = []

    if insertions > 0:
        frame = "frame-preserving" if insertions % 3 == 0 else "frameshift"
        comments.append(f"[Insertion of {insertions} bp – {frame}]")

    if deletions > 0:
        frame = "frame-preserving" if deletions % 3 == 0 else "frameshift"
        comments.append(f"[Deletion of {deletions} bp – {frame}]")

    return " ".join(comments) if comments else None


species_count = 0
gene_count = 0
file_count = 0

# ==========================
# MAIN LOOP
# ==========================
for species in os.listdir(BASE_DIR):

    if species in IGNORE:
        continue

    species_path = os.path.join(BASE_DIR, species)

    if not os.path.isdir(species_path):
        continue

    human_results = os.path.join(species_path, "HUMAN_Results")

    if not os.path.exists(human_results):
        continue

    species_count += 1
    print(f"\nProcessing species: {species}")

    for gene in os.listdir(human_results):

        gene_path = os.path.join(human_results, gene)

        if not os.path.isdir(gene_path):
            continue

        gene_count += 1
        print(f"  Processing gene: {gene}")

        for file in os.listdir(gene_path):

            # Ignore CDS files
            if "CDS" in file:
                continue

            # Process only BLAST alignment files
            if not file.endswith(("_blast.blast", "dcmegablast.blast", "short.blast")):
                continue

            file_count += 1

            inp = os.path.join(gene_path, file)
            out = os.path.join(gene_path, file.replace(".blast", "_with_comments.docx"))

            doc = Document()

            # Page setup
            sec = doc.sections[0]
            sec.orientation = WD_ORIENT.LANDSCAPE
            sec.page_width, sec.page_height = sec.page_height, sec.page_width
            sec.top_margin = sec.bottom_margin = Pt(36)
            sec.left_margin = sec.right_margin = Pt(36)

            with open(inp) as f:
                query_seq = ""
                subject_seq = ""

                for line in f:
                    L = line.rstrip()

                    p = doc.add_paragraph()
                    r = p.add_run(L)
                    r.font.name = "Consolas"
                    r.font.size = Pt(9)

                    parts = L.split()

                    if L.startswith("Query_") and len(parts) >= 3:
                        query_seq = parts[2]

                    elif len(parts) >= 3 and parts[1].isdigit():
                        subject_seq = parts[2]

                        if query_seq and subject_seq:
                            comment = detect_indels(query_seq, subject_seq)

                            if comment:
                                rc = p.add_run(" " + comment)
                                rc.font.name = "Consolas"
                                rc.font.size = Pt(9)
                                rc.font.bold = True
                                rc.font.color.rgb = RGBColor(200, 0, 0)
                                rc.font.highlight_color = WD_COLOR_INDEX.YELLOW

                            query_seq = ""
                            subject_seq = ""

            doc.save(out)
            print(f"    Saved → {out}")

print("\n=================================")
print(f"Species processed: {species_count}")
print(f"Genes processed: {gene_count}")
print(f"Files converted: {file_count}")
print("DONE ✅ All Word files created successfully")
print("=================================")

EOF

