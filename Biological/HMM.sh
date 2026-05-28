#!/bin/bash
set -e

mkdir -p 0.rawData/HMM 3.HMM/coords

DIR=3.HMM
COORD=$DIR/coords

rm -f "$COORD"/*.bed

HMM=0.rawData/HMM/E123_18_core_K27ac_dense.bed.gz
URL=https://egg2.wustl.edu/roadmap/data/byFileType/chromhmmSegmentations/ChmmModels/core_K27ac/jointModel/final/E123_18_core_K27ac_dense.bed.gz
JAR=path/to/chromhmm-1.27-0/ChromHMM.jar

[ -s "$HMM" ] || wget -O "$HMM" "$URL"

for f in 1.G4_bins/*_forHMM.bed
do
  name=$(basename "$f" _forHMM.bed)

  awk 'BEGIN{OFS="\t"} !/^(track|browser)/ && NF>=3 && $2<$3 {
    print $1,$2,$3
  }' "$f" > "$COORD/$name.bed"
done

gzip -dc "$HMM" |
  awk 'BEGIN{OFS="\t"} !/^(track|browser)/ && NF>=4 && $2<$3 {
    print $1,$2,$3,$4
  }' > "$DIR/E123_HMM.bed"

java -Xmx16g -jar "$JAR" OverlapEnrichment -labels \
  "$DIR/E123_HMM.bed" \
  "$COORD" \
  "$DIR/HMM_overlap"

Rscript supp3.plot_HMM.R \
  "$DIR/HMM_overlap.txt" \
  "$DIR/Roadmap_E123_K562_hg19_HMM18_FE.png"