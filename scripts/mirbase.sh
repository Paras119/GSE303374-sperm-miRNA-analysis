

mkdir -p references/mirbase

cd references/mirbase
wget https://zenodo.org/records/3502314/files/mature.fa.gz?download=1

gzip -dc references/mirbase/mature.fa.gz |   seqkit grep --use-regexp --pattern '^mmu-'   > references/mirbase/mature_mmu.fa

grep -c '^>' references/mirbase/mature_mmu.fa
head references/mirbase/mature_mmu.fa

