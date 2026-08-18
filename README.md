This repository contains an independent, reproducible bioinformatics reanalysis of publicly available small-RNA sequencing data associated with NCBI Gene Expression Omnibus accession GSE303374.

The original study investigated how paternal alcohol exposure affects the small-RNA composition of mouse sperm and examined its potential relationship with offspring growth and metabolism. This project focuses on processing and analysing the deposited sequencing data to identify differences in sperm microRNA abundance between experimental groups.


Procedure - 
1. Raw sequencing reads were extracted from the NCBI sequence read archive using prefetch command
    a. Project accesstions numbers were first retrieved from NCBI console using run extracter.
    b. Based on the fetched ids, the prefetch command with input arguments as -
        i. accession number text file
        ii. output directory
    c. The downloaded files were changed from .sra format to .fastq format using fasterq-dump command, and then compressed to .gz using pigz command to save disk storage.
    d. extracted files were tested and checked for integrity using gzip command.

2. 




Results - 
1. Alcohol dosage exposure differences in WT genotype
    a. Unsupervised PCA and correlation analysis on 12 samples - 4 control, 4 low, 2 medium and 2 high alcohol dosage exposures did not demonstrate a clear segregation of WT sperm miRNAs profiles. Most samples were strongly correlated, although one sample did show a comparative lower correlation compared to the remaining samples.