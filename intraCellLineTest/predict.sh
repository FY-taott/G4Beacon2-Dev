# data prepared
cp -r GenomeBins_plus_BED6_index00.bed plus_index00.bed
cut -d',' -f2-769 GenomeBins_plus_seq_index00.csv > plus_seq_index00_input.csv
cut -d',' -f2-201 GenomeBins_plus_HepG2_zscore_index00.csv > plus_HepG2_zscore_index00_input.csv

cp -r GenomeBins_minus_BED6_index00.bed minus_index00.bed
cut -d',' -f2-769 GenomeBins_minus_seq_index00.csv > minus_seq_index00_input.csv
cut -d',' -f2-201 GenomeBins_minus_HepG2_zscore_index00.csv > minus_HepG2_zscore_index00_input.csv

# predicting (WITHOUT ensemble)
g4beacon2 getValidatedG4s \
    --seqCSV minus_seq_index00_input.csv \
    --atacCSV minus_HepG2_zscore_index00_input.csv \
    --originBED minus_index00.bed \
    --model ../../6.trainall/upAndTrain/index1234/HepG2_zscoreDNABERT2_index1234_model.checkpoint.joblib \
    -o HepG21234_on_HepG200_minus.bed

g4beacon2 getValidatedG4s \
    --seqCSV plus_seq_index00_input.csv \
    --atacCSV plus_HepG2_zscore_index00_input.csv \
    --originBED plus_index00.bed \
    --model ../../6.trainall/upAndTrain/index1234/HepG2_zscoreDNABERT2_index1234_model.checkpoint.joblib \
    -o HepG21234_on_HepG200_plus.bed

# predicting (WITH ensemble)
for i in {00..04}; do
  g4beacon2 getValidatedG4s \
    --seqCSV plus_seq_index00_input.csv \
    --atacCSV plus_HepG2_zscore_index00_input.csv \
    --originBED plus_index00.bed \
    --model ../../6.trainall/upAndTrain/index1234/HepG2_zscoreDNABERT2_ES${i}_model.checkpoint.joblib \
    -o HepG21234_on_HepG200_plus_ES${i}.bed

  g4beacon2 getValidatedG4s \
    --seqCSV minus_seq_index00_input.csv \
    --atacCSV minus_HepG2_zscore_index00_input.csv \
    --originBED minus_index00.bed \
    --model ../../6.trainall/upAndTrain/index1234/HepG2_zscoreDNABERT2_ES${i}_model.checkpoint.joblib \
    -o HepG21234_on_HepG200_minus_ES${i}.bed


  cat HepG21234_on_HepG200_plus_ES${i}.bed \
      HepG21234_on_HepG200_minus_ES${i}.bed \
      > HepG21234_on_HepG200_ES${i}.bed
done

# $4,$8,$12,$16,$20 are the columns containing the prediction scores.
# If the BED file has additional information,
# please make sure to adjust and verify accordingly.

paste HepG21234_on_HepG200_ES00.bed \
      HepG21234_on_HepG200_ES01.bed \
      HepG21234_on_HepG200_ES02.bed \
      HepG21234_on_HepG200_ES03.bed \
      HepG21234_on_HepG200_ES04.bed \
      | awk '{sum=($7+$14+$21+$28+$35)/5; print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"sum}' \
      > HepG21234_on_HepG200_CellScore_new.bed