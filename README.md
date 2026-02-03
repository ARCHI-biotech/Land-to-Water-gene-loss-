# Genome-wide Identification of Vertebrate Homologs Using BLASTN

## Objective

To identify homologous genomic loci of **human genes** across **vertebrate species** by performing **BLASTN searches** against assembled vertebrate genomes using nucleotide sequences derived from **human genome annotation**.

---

## Overview of the Workflow

1. Retrieve human query sequences from annotation  
2. Download vertebrate genome assemblies  
3. Create BLAST nucleotide databases  
4. Perform BLASTN searches  
5. Filter and interpret BLAST hits  
6. Extract genomic coordinates and sequences  
7. Validate orthology  

---

## Step 1: Retrieve Human Query Sequences

## Step 2: Download Vertebrate Genome Assemblies

Genome assemblies for vertebrate species were downloaded from:

- Ensembl FTP
- NCBI RefSeq or GenBank
- UCSC Genome Browser

Example:

```bash
wget ftp://ftp.ensembl.org/pub/release-XXX/fasta/species/dna/*.fa.gz
gunzip *.fa.gz
```

Assemblies at chromosome or scaffold level were preferred.

---

## Step 3: Create BLAST Databases

BLAST+ (NCBI) was used to generate nucleotide databases for each species.

```bash
makeblastdb \
  -in species_genome.fa \
  -dbtype nucl \
  -parse_seqids \
  -out species_genome_db
```

Each species was indexed as an independent BLAST database.

---

## Step 4: Perform BLASTN Searches
