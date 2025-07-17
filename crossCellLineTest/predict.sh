# predicting vG4
for i in {00..04}; do
  g4beacon2 getValidatedG4s \
    --seqCSV DNABERT2_K562_vg4_plus_seq.csv \
    --atacCSV K562_vg4_plus_atac.csv \
    --originBED K562_vg4_plus_origin.bed \
    --model ../../3.intraCellTest/0.dataInGitHug/G4Beacon2-master/G4Beacon2/models/zscoreDNABERT2_HepG2_ES${i}_0517model.checkpoint.joblib \
    -o G4Beacon2onK562_vg4_ES${i}_plus.bed

  g4beacon2 getValidatedG4s \
    --seqCSV DNABERT2_K562_vg4_minus_seq.csv \
    --atacCSV K562_vg4_minus_atac.csv \
    --originBED K562_vg4_minus_origin.bed \
    --model ../../3.intraCellTest/0.dataInGitHug/G4Beacon2-master/G4Beacon2/models/zscoreDNABERT2_HepG2_ES${i}_0517model.checkpoint.joblib \
    -o G4Beacon2onK562_vg4_ES${i}_minus.bed


  cat G4Beacon2onK562_vg4_ES${i}_plus.bed \
      G4Beacon2onK562_vg4_ES${i}_minus.bed \
      > G4Beacon2onK562_vg4_ES${i}.bed
done


# predicting uG4 (negative)
for i in {00..04}; do
  g4beacon2 getValidatedG4s \
    --seqCSV DNABERT2_K562_ug4_plus_seq.csv \
    --atacCSV K562_ug4_plus_atac.csv \
    --originBED K562_ug4_plus_origin.bed \
    --model ../../3.intraCellTest/0.dataInGitHug/G4Beacon2-master/G4Beacon2/models/zscoreDNABERT2_HepG2_ES${i}_0517model.checkpoint.joblib \
    -o G4Beacon2onK562_ug4_ES${i}_plus.bed

  g4beacon2 getValidatedG4s \
    --seqCSV DNABERT2_K562_ug4_minus_seq.csv \
    --atacCSV K562_ug4_minus_atac.csv \
    --originBED K562_ug4_minus_origin.bed \
    --model ../../3.intraCellTest/0.dataInGitHug/G4Beacon2-master/G4Beacon2/models/zscoreDNABERT2_HepG2_ES${i}_0517model.checkpoint.joblib \
    -o G4Beacon2onK562_ug4_ES${i}_minus.bed


  cat G4Beacon2onK562_ug4_ES${i}_plus.bed \
      G4Beacon2onK562_ug4_ES${i}_minus.bed \
      > G4Beacon2onK562_ug4_ES${i}.bed
done

# $4,$8,$12,$16,$20 are the columns containing the prediction scores.
# If the BED file has additional information,
# please make sure to adjust and verify accordingly.

paste G4Beacon2onK562_vg4_ES00.bed \
      G4Beacon2onK562_vg4_ES01.bed \
      G4Beacon2onK562_vg4_ES02.bed \
      G4Beacon2onK562_vg4_ES03.bed \
      G4Beacon2onK562_vg4_ES04.bed \
      | awk '{sum=($4+$8+$12+$16+$20)/5; print $1"\t"$2"\t"$3"\t"sum}' \
      > G4Beacon2onK562_vg4_CellScore.bed

paste G4Beacon2onK562_ug4_ES00.bed \
      G4Beacon2onK562_ug4_ES01.bed \
      G4Beacon2onK562_ug4_ES02.bed \
      G4Beacon2onK562_ug4_ES03.bed \
      G4Beacon2onK562_ug4_ES04.bed \
      | awk '{sum=($4+$8+$12+$16+$20)/5; print $1"\t"$2"\t"$3"\t"sum}' \
      > G4Beacon2onK562_ug4_CellScore.bed

cut -f4 G4Beacon2onK562_ug4_CellScore.bed > G4Beacon2onK562_ug4_predictions.txt
cut -f4 G4Beacon2onK562_vg4_CellScore.bed > G4Beacon2onK562_vg4_predictions.txt

awk 'BEGIN { OFS="\t" } { $2 = 0 ; print }' G4Beacon2onK562_ug4_predictions.txt > G4Beacon2onK562_ug4_predictions.bed
awk 'BEGIN { OFS="\t" } { $2 = 1 ; print }' G4Beacon2onK562_vg4_predictions.txt > G4Beacon2onK562_vg4_predictions.bed

cat G4Beacon2onK562_vg4_predictions.bed \
    G4Beacon2onK562_ug4_predictions.bed \
    > G4Beacon2onK562_gkmSVM_predictions.bed