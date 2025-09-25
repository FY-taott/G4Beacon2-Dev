# $4,$9,$14 are the columns containing the prediction scores.
# If the BED file has additional information,
# please make sure to adjust and verify accordingly.

mkdir fusion

HepG2para=4
WT26para=4
H9para=1

#A549
cut -f1-3 H9/H9onA549_GenomeBins_ensemble.bed | md5sum 
cut -f1-3 HepG2/HepG2onA549_GenomeBins_ensemble.bed | md5sum 
cut -f1-3 WT26/WT26onA549_GenomeBins_ensemble.bed | md5sum 

paste H9/H9onA549_GenomeBins_ensemble.bed \
      HepG2/HepG2onA549_GenomeBins_ensemble.bed \
      WT26/WT26onA549_GenomeBins_ensemble.bed \
      | awk -v h9=$H9para -v hep=$HepG2para -v WT26=$WT26para \
      '{power=exp((log($4)*h9 + log($9)*hep + log($14)*WT26)/(h9 + hep + WT26)); print $1"\t"$2"\t"$3"\t"power"\t"$5}' \
      > fusion/G4Beacon2onA549_GenomeBins_ensemble.bed
