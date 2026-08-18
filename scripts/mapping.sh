

mkdir -p references/mirbase/index

bowtie-build \
  references/mirbase/mature_mmu.fa \
  references/mirbase/index/mmu_mature


# test
mkdir -p results/alignment/test

bowtie \
  -q \
  -S \
  -v 1 \
  -a \
  --best \
  --strata \
  -p 8 \
  references/mirbase/index/mmu_mature \
  data/trimmed/SRR34661416.trimmed.fastq.gz \
  2> results/alignment/test/SRR34661416.bowtie.log |
  samtools view -bS - |
  samtools sort \
    -o results/alignment/test/SRR34661416.sorted.bam

samtools index \
  results/alignment/test/SRR34661416.sorted.bam

cat results/alignment/test/SRR34661416.bowtie.log
samtools flagstat results/alignment/test/SRR34661416.sorted.bam




for fq in data/trimmed/*.trimmed.fastq.gz; do
  sample=$(basename "$fq" .trimmed.fastq.gz)

  seqkit seq \
    --min-len 19 \
    --max-len 26 \
    "$fq" \
    --out-file "data/mirna_length_filtered/${sample}.19-26nt.fastq.gz"

  bowtie \
    -q \
    -S \
    -v 1 \
    -m 1 \
    --best \
    --strata \
    --norc \
    -p 8 \
    -x references/mirbase/index_dna/mmu_mature \
    "data/mirna_length_filtered/${sample}.19-26nt.fastq.gz" \
    2> "results/alignment/logs/${sample}.bowtie.log" |
    samtools view -bS - |
    samtools sort \
      -o "results/alignment/bam/${sample}.sorted.bam"

  samtools index \
    "results/alignment/bam/${sample}.sorted.bam"
done


for bam in results/alignment/bam/*.sorted.bam; do
  sample=$(basename "$bam" .sorted.bam)

  samtools idxstats "$bam" |
    awk -v sample="$sample" '
      BEGIN {OFS="\t"; print "miRNA", sample}
      $1 != "*" {print $1, $3}
    ' > "results/counts/${sample}.counts.tsv"
done