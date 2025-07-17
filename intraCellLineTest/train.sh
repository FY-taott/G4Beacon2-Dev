# cat index1/2/3/4
mkdir index1234
cd index1234

cat ../../zscore_vg4_atac_index01.csv \
    ../../zscore_vg4_atac_index02.csv \
    ../../zscore_vg4_atac_index03.csv \
    ../../zscore_vg4_atac_index04.csv \
    > zscore_vg4_atac_index1234.csv
    
cat ../../DNABERT2_vg4_seq_index01.csv \
    ../../DNABERT2_vg4_seq_index02.csv \
    ../../DNABERT2_vg4_seq_index03.csv \
    ../../DNABERT2_vg4_seq_index04.csv \
    > DNABERT2_vg4_seq_index1234.csv

cat ../../zscore_ug4_atac_index01.csv \
    ../../zscore_ug4_atac_index02.csv \
    ../../zscore_ug4_atac_index03.csv \
    ../../zscore_ug4_atac_index04.csv \
    > zscore_ug4_atac_index1234.csv

cat ../../DNABERT2_ug4_seq_index01.csv \
    ../../DNABERT2_ug4_seq_index02.csv \
    ../../DNABERT2_ug4_seq_index03.csv \
    ../../DNABERT2_ug4_seq_index04.csv \
    > DNABERT2_ug4_seq_index1234.csv
    
# upsampling
g4beacon2 trainingsetConstruct \
       --vg4seqCSV  DNABERT2_vg4_seq_index1234.csv \
       --ug4seqCSV  DNABERT2_ug4_seq_index1234.csv \
       --vg4atacCSV zscore_vg4_atac_index1234.csv \
       --ug4atacCSV zscore_ug4_atac_index1234.csv \
       --outdir     ./

# direct training WITHOUT ensemble (control)
g4beacon2 trainOwnData \
    --vg4seqCSV  trainPos.seq.full.csv \
    --ug4seqCSV  trainNeg.seq.full.csv \
    --vg4atacCSV trainPos.atac.full.csv \
    --ug4atacCSV trainNeg.atac.full.csv \
    --oname      HepG2_zscoreDNABERT2_index1234_model \
    --outdir     ./

# ensemble prepared
paste -d ',' trainPos.seq.full.csv trainPos.atac.full.csv > trainPos.seqAtac.full.csv
paste -d ',' trainNeg.seq.full.csv trainNeg.atac.full.csv > trainNeg.seqAtac.full.csv

shuf trainPos.seqAtac.full.csv > shuf.trainPos.seqAtac.full.csv
shuf trainNeg.seqAtac.full.csv > shuf.trainNeg.seqAtac.full.csv

split -d -n l/5 --additional-suffix=.csv shuf.trainPos.seqAtac.full.csv shuf.trainPos.seqAtac.part
split -d -n l/5 --additional-suffix=.csv shuf.trainNeg.seqAtac.full.csv shuf.trainNeg.seqAtac.part

for dataset in trainNeg trainPos; do
  for i in {00..04}; do
    cut -d ',' -f 1-768 shuf.${dataset}.seqAtac.part${i}.csv > shuf.${dataset}.seq.part${i}.csv
    cut -d ',' -f 769-968 shuf.${dataset}.seqAtac.part${i}.csv > shuf.${dataset}.atac.part${i}.csv
  done
done

# training WITH ensemble (experiment)
for i in {00..04}; do
  g4beacon2 trainOwnData \
    --vg4seqCSV  shuf.trainPos.seq.part${i}.csv \
    --ug4seqCSV  shuf.trainNeg.seq.part${i}.csv \
    --vg4atacCSV shuf.trainPos.atac.part${i}.csv \
    --ug4atacCSV shuf.trainNeg.atac.part${i}.csv \
    --oname      HepG2_zscoreDNABERT2_ES${i}_model \
    --outdir     ./
done

