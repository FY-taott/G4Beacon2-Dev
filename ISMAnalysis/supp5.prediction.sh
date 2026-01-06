for i in {00..04}; do
  g4beacon2 getValidatedG4s \
    --seqCSV 		DNABERT2_mutateISM2.0.csv \
    --atacCSV	 	TESTNAME_std.atac.8000.csv \
    --originBED 	TESTNAME_std.origin.8000.bed \
    --model		G4Beacon2/models/zscoreDNABERT2_HepG2_ES${i}_0517model.checkpoint.joblib \
    -o TESTNAME_std_predicion_ES${i}_ISM.bed
done

# $4,$8,$12,$16,$20 are the columns containing the prediction scores.
# If the BED file has additional information,
# please make sure to adjust and verify accordingly.

paste TESTNAME_std_predicion_ES00_ISM.bed \
      TESTNAME_std_predicion_ES01_ISM.bed \
      TESTNAME_std_predicion_ES02_ISM.bed \
      TESTNAME_std_predicion_ES03_ISM.bed \
      TESTNAME_std_predicion_ES04_ISM.bed \
      | awk '{sum=($4+$8+$12+$16+$20)/5; print $1"\t"$2"\t"$3"\t"sum}' \
      > TESTNAME_std_predicion_CellScore_ISM.bed
