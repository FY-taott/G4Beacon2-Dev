### OG4-P NOT-P OG4-M NOT-M

cat BinsFromOG4_hg19_plus_origin.bed \
    BinsNotFromOG4_hg19_plus_origin.bed \
    > GenomeBins_hg19_plus_origin.bed

cat BinsFromOG4_hg19_minus_origin.bed \
    BinsNotFromOG4_hg19_minus_origin.bed \
    > GenomeBins_hg19_minus_origin.bed

cat BinsFromOG4_hg19_plus_seq.csv \
    BinsNotFromOG4_hg19_plus_seq.csv \
    > GenomeBins_hg19_plus_seq.csv

cat BinsFromOG4_hg19_minus_seq.csv \
    BinsNotFromOG4_hg19_minus_seq.csv \
    > GenomeBins_hg19_minus_seq.csv

cat BinsFromOG4_hg19_plus_HepG2_zscore.csv \
    BinsNotFromOG4_hg19_plus_HepG2_zscore.csv \
    > GenomeBins_hg19_plus_HepG2_zscore.csv

cat BinsFromOG4_hg19_minus_HepG2_zscore.csv \
    BinsNotFromOG4_hg19_minus_HepG2_zscore.csv \
    > GenomeBins_hg19_minus_HepG2_zscore.csv


## get IDs
awk 'BEGIN{OFS="\t"} {print $0, "IDp"NR, ".", "+"}' GenomeBins_hg19_plus_origin.bed > ID_GenomeBins_hg19_plus_origin.bed
awk 'BEGIN{OFS="\t"} {print $0, "IDm"NR, ".", "-"}' GenomeBins_hg19_minus_origin.bed > ID_GenomeBins_hg19_minus_origin.bed

awk -F',' 'BEGIN{OFS=","} {print "IDp"NR, $0}' GenomeBins_hg19_plus_seq.csv > ID_GenomeBins_hg19_plus_seq.csv
awk -F',' 'BEGIN{OFS=","} {print "IDm"NR, $0}' GenomeBins_hg19_minus_seq.csv > ID_GenomeBins_hg19_minus_seq.csv

awk -F',' 'BEGIN{OFS=","} {print "IDp"NR, $0}' GenomeBins_hg19_plus_HepG2_zscore.csv > ID_GenomeBins_hg19_plus_HepG2_zscore.csv
awk -F',' 'BEGIN{OFS=","} {print "IDm"NR, $0}' GenomeBins_hg19_minus_HepG2_zscore.csv > ID_GenomeBins_hg19_minus_HepG2_zscore.csv

# get vG4
bedtools intersect -a ID_GenomeBins_hg19_plus_origin.bed \
                    -b sorted_HepG2_hg19.bed \
                    -wa -F 0.1 | sort -k1,1 -k2,2n -u > ID_GenomeBins_plus_label_1.bed

bedtools intersect -a ID_GenomeBins_hg19_plus_origin.bed \
                    -b sorted_HepG2_hg19.bed \
                    -v -F 0.1 | sort -k1,1 -k2,2n -u > ID_GenomeBins_plus_label_0.bed

bedtools intersect -a ID_GenomeBins_hg19_minus_origin.bed \
                    -b sorted_HepG2_hg19.bed \
                    -wa -F 0.1 | sort -k1,1 -k2,2n -u > ID_GenomeBins_minus_label_1.bed

bedtools intersect -a ID_GenomeBins_hg19_minus_origin.bed \
                    -b sorted_HepG2_hg19.bed \
                    -v -F 0.1 | sort -k1,1 -k2,2n -u > ID_GenomeBins_minus_label_0.bed

# get labels                    
awk 'BEGIN{OFS="\t"} {$5=1; print}' ID_GenomeBins_plus_label_1.bed > ID_GenomeBins_plus_label_1_BED6.bed
awk 'BEGIN{OFS="\t"} {$5=1; print}' ID_GenomeBins_minus_label_1.bed > ID_GenomeBins_minus_label_1_BED6.bed

awk 'BEGIN{OFS="\t"} {$5=0; print}' ID_GenomeBins_plus_label_0.bed > ID_GenomeBins_plus_label_0_BED6.bed
awk 'BEGIN{OFS="\t"} {$5=0; print}' ID_GenomeBins_minus_label_0.bed > ID_GenomeBins_minus_label_0_BED6.bed

# get benchmark
cat ID_GenomeBins_plus_label_1_BED6.bed ID_GenomeBins_plus_label_0_BED6.bed > ID_GenomeBins_plus_BED6.bed
cat ID_GenomeBins_minus_label_1_BED6.bed ID_GenomeBins_minus_label_0_BED6.bed > ID_GenomeBins_minus_BED6.bed

# sort benchmark
sort -k4,4V ID_GenomeBins_plus_BED6.bed > sorted_ID_GenomeBins_plus_BED6.bed
sort -k4,4V ID_GenomeBins_minus_BED6.bed > sorted_ID_GenomeBins_minus_BED6.bed