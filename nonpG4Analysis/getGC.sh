#negative 0
bedtools shuffle -i K562_m10_peaks_all.bed \
                 -excl merged_black_gap.bed \
                 -seed 42 \
                 -g hg19_pure.chrom.sizes \
                 > K562_m10_peaks_all_negativeShuffle42.bed

bedtools getfasta -fi hg19.fa \
                  -bed K562_m10_peaks_all_negativeShuffle42.bed \
                  -fo K562_m10_peaks_all_negativeShuffle42.fa

geecee -sequence K562_m10_peaks_all_negativeShuffle42.fa -outfile K562_m10_peaks_all_negativeShuffle42_gc_content.txt

# without 0-20
bedtools getfasta -fi hg19.fa \
                  -bed K562_m10_withoutPQS_all_without20score.bed \
                  -fo K562_m10_withoutPQS_all_without20score.fa

geecee -sequence K562_m10_withoutPQS_all_without20score.fa -outfile K562_m10_withoutPQS_all_without20score_gc_content.txt

# with 20-50
bedtools getfasta -fi hg19.fa \
                  -bed K562_m10_withoutPQS_all_with20score.bed \
                  -fo K562_m10_withoutPQS_all_with20score.fa

geecee -sequence K562_m10_withoutPQS_all_with20score.fa -outfile K562_m10_withoutPQS_all_with20score_gc_content.txt


# 50+
bedtools getfasta -fi hg19.fa \
                  -bed K562_m10_withPQS_all.bed \
                  -fo K562_m10_withPQS_all.fa

geecee -sequence K562_m10_withPQS_all.fa -outfile K562_m10_withPQS_all_gc_content.txt