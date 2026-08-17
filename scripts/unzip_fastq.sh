#!/usr/bin/bash

# utilize fasterq-dump for .sra extraction into .fq

while read -r run; do
    fasterq-dump \
        "data/sra/${run}/${run}.sra" \
        --outdir data/fastq \
        --temp data/tmp \
        --threads 8 \
        --progress
done < metadata/srr_accession.txt

# zip the .fq files to save space
pigz -p 8 data/fastq/*.fastq

# test that the .fq.gz files are valid
gzip -t data/fastq/*.fastq.gz