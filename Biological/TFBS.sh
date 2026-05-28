#!/bin/bash
set -e

mkdir -p 2.TFBS

DIR=2.TFBS

TF=$DIR/K562_TFBS_TFonly.bed
ALL=$DIR/all_G4_regions.tsv
PAIR=$DIR/G4_TF_pairs.tsv
COUNT=$DIR/G4_TF_count.tsv
TABLE=$DIR/TF_count_per_G4.withZero.tsv

awk 'BEGIN{OFS="\t"} !/^(track|browser)/ && NF>=4 && $2<$3 {
  n=split($4,a,"_")
  print $1,$2,$3,a[n-1]
}' 0.rawData/TFBS/sort_hg19_K562_TFBSs.bed | sort -u > "$TF"

> "$ALL"
> "$PAIR"

for f in 1.G4_bins/*_forHMM.bed
do
  name=$(basename "$f" _forHMM.bed)
  bin=${name#*_}
  g4=$DIR/$name.withID.bed

  awk -v b="$bin" 'BEGIN{OFS="\t"} NF>=3 && $2<$3 {
    print $1,$2,$3,"G4_"b"_"NR
  }' "$f" > "$g4"

  awk -v b="$bin" 'BEGIN{OFS="\t"} {
    print b,$4,$1,$2,$3
  }' "$g4" >> "$ALL"

  bedtools intersect -a "$g4" -b "$TF" -wa -wb |
    awk -v b="$bin" 'BEGIN{OFS="\t"} {
      print b,$4,$8
    }' >> "$PAIR"
done

sort -u "$PAIR" |
  cut -f1,2 |
  sort |
  uniq -c |
  awk 'BEGIN{OFS="\t"} {print $2,$3,$1}' > "$COUNT"

awk 'BEGIN{OFS="\t"}
  FILENAME==ARGV[1] {
    n[$1"\t"$2]=$3
    next
  }
  FILENAME==ARGV[2] {
    print $0, n[$1"\t"$2]+0
  }
' "$COUNT" "$ALL" > "$TABLE"

Rscript supp2.plot_TFBS.R "$TABLE" "$DIR/plot_TF_count_boxplot_all.png"