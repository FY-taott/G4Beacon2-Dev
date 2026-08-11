#!/usr/bin/env bash
# Environment: gccontrol
cd "$(dirname "$0")"

BED="data/subseq.bed"
HG19="hg19.fa"
MOTIF_INPUT="data/consecutive_G.meme"

mkdir -p temp result
samtools faidx "$HG19"

cut -f1-3 "$BED" > temp/important_986.bed3
awk 'BEGIN{OFS="\t"}{printf "%s\t%s\t%s\tIMP_%04d\n",$1,$2,$3,NR}' \
  temp/important_986.bed3 > temp/important_986.bed4
bedtools getfasta -fi "$HG19" -bed temp/important_986.bed4 -nameOnly \
  | awk '/^>/{print;next}{print toupper($0)}' > temp/important_986.fa
cp "$MOTIF_INPUT" temp/active_motif.meme

cut -f1,2 "$HG19.fai" > temp/hg19.genome
bedtools random -l 200 -n 1250000 -seed 1 -g temp/hg19.genome \
  | bedtools intersect -v -a stdin -b temp/important_986.bed3 \
  | awk 'BEGIN{OFS="\t"}{print $1,$2,$3,"P"NR}' > temp/pool.bed4
bedtools getfasta -fi "$HG19" -bed temp/pool.bed4 -nameOnly \
  | awk '
      function emit(){
        sequence=toupper(sequence)
        if(length(sequence)==200 && sequence~/^[ACGT]+$/ && n<1000000)
          printf ">MPOOL_%07d\n%s\n",++n,sequence
      }
      /^>/{if(header)emit();sequence="";header=1;next}
      {sequence=sequence $0}
      END{if(header)emit()}
    ' > temp/genomic_pool_1000000.fa

echo "Preparation complete"
