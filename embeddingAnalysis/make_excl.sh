cut -f1-3 ENCFF001TDO_blacklist_hg19.bed > black.bed3

cat black.bed3 gap.bed > black_gap.bed
bedtools sort -i black_gap.bed > sorted_black_gap.bed
bedtools merge -i sorted_black_gap.bed > merged_black_gap.bed