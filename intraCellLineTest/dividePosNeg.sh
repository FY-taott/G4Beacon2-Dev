# paste all files to classify pos/neg
paste -d, <(awk '{print $4","$5}' GenomeBins_minus_BED6_index00.bed) \
      GenomeBins_minus_seq_index00.csv \
      GenomeBins_minus_HepG2_zscore_index00.csv \
      > GenomeBins_minus_index00_bedSeqAtac.csv

paste -d, <(awk '{print $4","$5}' GenomeBins_plus_BED6_index00.bed) \
      GenomeBins_plus_seq_index00.csv \
      GenomeBins_plus_HepG2_zscore_index00.csv \
      > GenomeBins_plus_index00_bedSeqAtac.csv

## divide pos/neg
awk -F',' '$2 == 0' GenomeBins_minus_index00_bedSeqAtac.csv > GenomeBins_minus_index00_bedSeqAtac_Neg.csv
awk -F',' '$2 == 0' GenomeBins_plus_index00_bedSeqAtac.csv > GenomeBins_plus_index00_bedSeqAtac_Neg.csv

awk -F',' '$2 == 1' GenomeBins_minus_index00_bedSeqAtac.csv > GenomeBins_minus_index00_bedSeqAtac_Pos.csv
awk -F',' '$2 == 1' GenomeBins_plus_index00_bedSeqAtac.csv > GenomeBins_plus_index00_bedSeqAtac_Pos.csv

## separate
cut -d',' -f4-771 GenomeBins_plus_index00_bedSeqAtac_Pos.csv > GenomeBins_plus_index00_Pos_seq.csv
cut -d',' -f773-972 GenomeBins_plus_index00_bedSeqAtac_Pos.csv > GenomeBins_plus_index00_Pos_atac.csv

cut -d',' -f4-771 GenomeBins_minus_index00_bedSeqAtac_Pos.csv > GenomeBins_minus_index00_Pos_seq.csv
cut -d',' -f773-972 GenomeBins_minus_index00_bedSeqAtac_Pos.csv > GenomeBins_minus_index00_Pos_atac.csv

cut -d',' -f4-771 GenomeBins_plus_index00_bedSeqAtac_Neg.csv > GenomeBins_plus_index00_Neg_seq.csv
cut -d',' -f773-972 GenomeBins_plus_index00_bedSeqAtac_Neg.csv > GenomeBins_plus_index00_Neg_atac.csv

cut -d',' -f4-771 GenomeBins_minus_index00_bedSeqAtac_Neg.csv > GenomeBins_minus_index00_Neg_seq.csv
cut -d',' -f773-972 GenomeBins_minus_index00_bedSeqAtac_Neg.csv > GenomeBins_minus_index00_Neg_atac.csv

# cat all files
cat GenomeBins_plus_index00_Pos_atac.csv \
    GenomeBins_minus_index00_Pos_atac.csv \
    > zscore_vg4_atac_index00.csv

cat GenomeBins_plus_index00_Neg_atac.csv \
    GenomeBins_minus_index00_Neg_atac.csv \
    > zscore_ug4_atac_index00.csv


cat GenomeBins_plus_index00_Pos_seq.csv \
    GenomeBins_minus_index00_Pos_seq.csv \
    > DNABERT2_vg4_seq_index00.csv

cat GenomeBins_plus_index00_Neg_seq.csv \
    GenomeBins_minus_index00_Neg_seq.csv \
    > DNABERT2_ug4_seq_index00.csv
