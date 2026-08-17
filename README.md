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