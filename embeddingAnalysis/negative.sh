# positive region
cat UpstreamAll_1000shuf.bed6 \
    DownstreamAll_1000shuf.bed6 \
    WholeGeneAll_1kbScale.bed \
    ExonsAll_1kbScale.bed \
    IntronsAll_1kbScale.bed \
    > positive_both1k_1kb.bed

# gene and up/down 1kb
cat UpstreamBy1k_hg19_STD_raw.bed6 \
    DownstreamBy1k_hg19_STD_raw.bed6 \
    WholeGene_hg19_STD_raw.bed6 \
    > gene_all_up_down.bed
    
cut -f1-6 gene_all_up_down.bed > gene_all_up_down.bed6
bedtools sort -i gene_all_up_down.bed6 > sorted_gene_all_up_down.bed
bedtools merge -i sorted_gene_all_up_down.bed -s -c 6 -o distinct > merged_gene_all_up_down.bed
cut -f1-3 merged_gene_all_up_down.bed > merged_gene_all_up_down.bed3

# exclude gap,black,gene and up/down
cat merged_black_gap.bed > excl.bed
bedtools sort -i excl.bed > sorted_excl.bed
bedtools merge -i sorted_excl.bed > merged_excl.bed

# negative
bedtools shuffle -i positive_both1k_1kb.bed \
                 -excl merged_excl.bed \
                 -seed 42 \
                 -g hg19_pure.chrom.sizes \
                 > NegativeFromGeneAndUpDown_Shuffle42.bed4



shuf -n 1000 NegativeFromGeneAndUpDown_Shuffle42.bed4 > NegativeFromGeneAndUpDown_Shuffle42_1000shuf.bed4


awk 'BEGIN{OFS="\t"} {print $1,$2,$3,".",".",$4}' NegativeFromGeneAndUpDown_Shuffle42_1000shuf.bed4 > NegativeFromGeneAndUpDown_Shuffle42_1000shuf.bed6

bedtools getfasta -fi hg19.fa \
                  -bed NegativeFromGeneAndUpDown_Shuffle42_1000shuf.bed6 \
                  -s \
                  -tab \
                  -fo NegativeFromGeneAndUpDown_Shuffle42_1000shuf.tab

cut -f2 NegativeFromGeneAndUpDown_Shuffle42_1000shuf.tab > NegativeFromGeneAndUpDown_Shuffle42_1000shuf.txt

awk '{print toupper($0)}' NegativeFromGeneAndUpDown_Shuffle42_1000shuf.txt >  NegativeFromGeneAndUpDown_Shuffle42_1000shuf_upper.txt

#then embedding 