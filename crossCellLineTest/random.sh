cut -f1-3 \
    ENCFF001TDO_blacklist_hg19.bed \
    > ENCFF001TDO_blacklist_hg19.bed3
    
cat ENCFF001TDO_blacklist_hg19.bed3 \
    gap.bed \
    sorted_K562_hg19.bed \
    > excl_cat.bed

sort -k1,1 -k2,2n excl_cat.bed > excl_sort.bed
bedtools merge -i excl_sort.bed > excl_final.bed

bedtools shuffle -i K562_vg4_plus_origin.bed \
                 -g hg19_pure.chrom.sizes \
                 -excl excl_final.bed \
                 -seed 42 \
                 > K562_ug4rand42_plus_origin.bed

bedtools shuffle -i K562_vg4_minus_origin.bed \
                 -g hg19_pure.chrom.sizes \
                 -excl excl_final.bed \
                 -seed 42 \
                 > K562_ug4rand42_minus_origin.bed