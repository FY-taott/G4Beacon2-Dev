# clean shuffled results
awk '$1 ~ /^chr([1-9]|1[0-9]|2[0-2]|X|Y)$/' K562_ug4gkm_plus_origin.bed > K562_ug4gkmSTD_plus_origin.bed
awk '$1 ~ /^chr([1-9]|1[0-9]|2[0-2]|X|Y)$/' K562_ug4gkm_minus_origin.bed > K562_ug4gkmSTD_minus_origin.bed

# sort
bedtools sort -i K562_ug4gkmSTD_plus_origin.bed > sorted_K562_ug4gkmSTD_plus_origin.bed
bedtools sort -i K562_ug4gkmSTD_minus_origin.bed > sorted_K562_ug4gkmSTD_minus_origin.bed

# ug4 
bedtools intersect -a sorted_K562_ug4gkmSTD_minus_origin.bed \
                    -b sorted_K562_hg19.bed \
                    -v -F 0.1 | sort -k1,1 -k2,2n -u > sorted_K562_ug4gkmSTD_minus_origin_below10.bed

bedtools intersect -a sorted_K562_ug4gkmSTD_plus_origin.bed \
                    -b sorted_K562_hg19.bed \
                    -v -F 0.1 | sort -k1,1 -k2,2n -u > sorted_K562_ug4gkmSTD_plus_origin_below10.bed

# raw sequence file in CSV format (same with g4beacon: ug4 is negative)       
g4beacon2 seqFeatureConstruct \
     -i    sorted_K562_ug4gkmSTD_minus_origin_below10.bed \
     -fi   hg19.fa \
     -oseq K562_ug4_minus_seq.csv \
     -obi  K562_ug4_minus_origin.bed \
     --reverse

g4beacon2 seqFeatureConstruct \
     -i    sorted_K562_ug4gkmSTD_plus_origin_below10.bed \
     -fi   hg19.fa \
     -oseq K562_ug4_plus_seq.csv \
     -obi  K562_ug4_plus_origin.bed


g4beacon2 atacFeatureConstruct \
       -p          24 \
       --g4Input   K562_ug4_minus_origin.bed \
       --envInput  K562_ATAC_hg19_zscore.bigwig \
       --csvOutput K562_ug4_minus_atac.csv

g4beacon2 atacFeatureConstruct \
       -p          24 \
       --g4Input   K562_ug4_plus_origin.bed \
       --envInput  K562_ATAC_hg19_zscore.bigwig \
       --csvOutput K562_ug4_plus_atac.csv


awk -F, 'BEGIN {OFS=""; map="ACGT"} {for (i=1; i<=NF; i++) printf "%s", substr(map, $i+1, 1); print ""}' \
    K562_ug4_minus_seq.csv > K562_ug4_minus_seq.txt
    

awk -F, 'BEGIN {OFS=""; map="ACGT"} {for (i=1; i<=NF; i++) printf "%s", substr(map, $i+1, 1); print ""}' \
    K562_ug4_plus_seq.csv > K562_ug4_plus_seq.txt

# then use DNABERT2