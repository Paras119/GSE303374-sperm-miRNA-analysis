#!/usr/bin/bash

fastqc \
    --threads 8 \
    --outdir results/qc/raw \
    data/fastq/*.gz

multiqc \
    --outdir results/qc/raw \
    results/qc/raw