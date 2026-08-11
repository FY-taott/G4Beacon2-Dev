#!/usr/bin/env bash
# Environment: gccontrol
cd "$(dirname "$0")"
K=100
mkdir -p temp/exact

for mer in 1 2 3; do
  for ((seed=1; seed<=K; seed++)); do
    output=$(printf 'temp/exact/exact_k%d_r%03d.fa' "$mer" "$seed")
    fasta-shuffle-letters -dna -kmer "$mer" -copies 1 -seed "$seed" \
      temp/important_986.fa temp/exact/shuffled.fa
    awk '/^>/{printf ">IMP_%04d\n",++n;next}{print toupper($0)}' \
      temp/exact/shuffled.fa > "$output"
  done
done

echo "MEME/uShuffle complete: k=1-3; K=$K"
