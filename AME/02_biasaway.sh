#!/usr/bin/env bash
# Environment: biasaway
cd "$(dirname "$0")"
K=100

FOREGROUND=temp/important_986.fa
POOL=temp/genomic_pool_1000000.fa
OUTPUT=temp/biasaway
REPOSITORY=temp/biasaway_bg_g
mkdir -p "$OUTPUT" "$REPOSITORY"

normalize_fasta() {
  awk '/^>/{printf ">IMP_%04d\n",++n;next}{print toupper($0)}'
}

for mer in 1 2 3; do
  for ((seed=1; seed<=K; seed++)); do
    biasaway w -f "$FOREGROUND" -k "$mer" -n 1 -w 100 -s 50 -e "$seed" \
      | normalize_fasta > "$(printf '%s/bias_window_k%d_r%03d.fa' "$OUTPUT" "$mer" "$seed")"
  done
done

biasaway g -f "$FOREGROUND" -b "$POOL" -r "$REPOSITORY" -n 1 -e 1 \
  | normalize_fasta > "$OUTPUT/bias_g_r001.fa"
for ((seed=2; seed<=K; seed++)); do
  biasaway g -f "$FOREGROUND" -r "$REPOSITORY" -n 1 -e "$seed" \
    | normalize_fasta > "$(printf '%s/bias_g_r%03d.fa' "$OUTPUT" "$seed")"
done

echo "BiasAway complete: window k=1-3 and genomic g; K=$K"
