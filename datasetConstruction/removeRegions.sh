# gap removed
bedtools intersect -a hg19_pure_w2k.bed -b gap.bed -wa -v > hg19_nogap_w2k.bed

# blacklist removed
bedtools intersect -a hg19_nogap_w2k.bed -b ENCFF001TDO_blacklist_hg19.bed -wa -v > hg19_nogap_noB_w2k.bed

# The final BED file generated by this script, when combined with the oG4 dataset, forms the GenomeBins.
# Thus, duplicate oG4 entries must be removed first.
bedtools intersect -a hg19_nogap_noB_w2k.bed -b G4seqsMG4_plus_slop50.bed -v -wa > hg19_NOs_nonOG4_plus.bed
bedtools intersect -a hg19_nogap_noB_w2k.bed -b G4seqsMG4_minus_slop50.bed -v -wa > hg19_NOs_nonOG4_minus.bed

# H9,K562,HepG2,K562C,MCF7 merged
# aG4 without oG4 (not validated) removed
bedtools intersect -a hg19_NOs_nonOG4_plus.bed -b merged_ag4.bed -v -wa > BinsNotFromOG4_hg19_plus.bed
bedtools intersect -a hg19_NOs_nonOG4_minus.bed -b merged_ag4.bed -v -wa > BinsNotFromOG4_hg19_minus.bed