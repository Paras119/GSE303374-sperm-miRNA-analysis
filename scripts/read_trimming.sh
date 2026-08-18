#!/usr/bin/bash

# check if adapter sequence is correct
mkdir -p results/trimming/check

for fq in data/fastq/*.fastq.gz; do
  sample=$(basename "$fq" .fastq.gz)

  cutadapt \
    --cores 8 \
    --adapter AACTGTAGGCACCATCAAT \
    --action=none \
    --output /dev/null \
    "$fq" \
    > "results/trimming/check/${sample}.txt"
done

grep -H 'Reads with adapters' results/trimming/check/*.txt


# trim the reads
mkdir -p data/trimmed results/trimming/logs

for fq in data/fastq/*.fastq.gz; do
  sample=$(basename "$fq" .fastq.gz)

  cutadapt \
    --cores 8 \
    --adapter AACTGTAGGCACCATCAAT \
    --discard-untrimmed \
    --quality-cutoff 20 \
    --minimum-length 15 \
    --maximum-length 55 \
    --output "data/trimmed/${sample}.trimmed.fastq.gz" \
    "$fq" \
    > "results/trimming/logs/${sample}.cutadapt.txt"
done


mkdir -p results/qc/trimmed

fastqc \
  --threads 8 \
  --outdir results/qc/trimmed \
  data/trimmed/*.trimmed.fastq.gz

multiqc \
  --force \
  --filename multiqc_trimmed_report.html \
  --outdir results/qc/trimmed \
  results/qc/trimmed \
  results/trimming/logs