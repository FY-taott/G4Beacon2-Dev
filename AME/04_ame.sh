#!/usr/bin/env bash
# Environment: gccontrol
cd "$(dirname "$0")"
K=100
FOREGROUND=temp/important_986.fa
MOTIF=temp/active_motif.meme
mkdir -p result

printf 'method\tlabel\treplicate\tp_value\tadj_p_value\te_value\ttests\n' \
  > result/AME_all_replicates.tsv
completed=0

run_family() {
  local method=$1 label=$2 pattern=$3 seed control values
  for ((seed=1; seed<=K; seed++)); do
    control=$(printf "$pattern" "$seed")
    values=$(ame --verbose 1 --text \
      --control "$control" --method fisher --scoring avg \
      "$FOREGROUND" "$MOTIF" \
      | awk -F'\t' 'BEGIN{OFS="\t"}
          /^#/ {next}
          !header {for(i=1;i<=NF;i++) column[$i]=i; header=1; next}
          {print $(column["p-value"]),$(column["adj_p-value"]),$(column["E-value"]),$(column["tests"]); exit}
        ')
    printf '%s\t%s\t%d\t%s\n' "$method" "$label" "$seed" "$values" \
      >> result/AME_all_replicates.tsv
    completed=$((completed+1))
    if (( completed % 100 == 0 )); then echo "AME: $completed controls complete"; fi
  done
}

for mer in 1 2 3; do
  run_family "exact_k$mer" "Exact k=$mer (MEME/uShuffle)" \
    "temp/exact/exact_k${mer}_r%03d.fa"
done
for mer in 1 2 3; do
  run_family "bias_window_k$mer" "BiasAway window k=$mer" \
    "temp/biasaway/bias_window_k${mer}_r%03d.fa"
done
run_family bias_g "BiasAway genomic global (g)" "temp/biasaway/bias_g_r%03d.fa"
run_family gennull "gkmSVM genNullSeqs" "temp/gennull/gennull_r%03d.fa"

echo "AME complete: 8 settings x $K replicates"
