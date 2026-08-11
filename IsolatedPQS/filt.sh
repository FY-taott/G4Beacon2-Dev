#!/bin/bash

head -n 1 ../plus/seed1/merged_scores_plus.tsv > merged_scores.tsv

for seed in {1..10}; do
    for f in \
        ../plus/seed${seed}/merged_scores_plus.tsv \
        ../minus/seed${seed}/merged_scores_minus.tsv
    do
        tail -n +2 "$f" >> merged_scores.tsv
    done
done

awk 'BEGIN{FS=OFS="\t"} NR==1 || $4>0.5' merged_scores.tsv > merged_scores_0.5.tsv