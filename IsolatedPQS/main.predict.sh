#!/bin/bash
set -euo pipefail

cd plus

types=(random edge_G center_G)

python3 supp2.mutateGGG2bed5.py

for seed in {1..10}; do
    seed_dir="seed${seed}"

    # Generate mutated sequences
    for x in "${types[@]}"; do
        python3 supp3.mutate.py \
            "${seed_dir}/lonely.K562_plus_${x}.bed5" \
            lonely.K562_plus.oseq.txt \
            "${seed_dir}/lonely.K562_plus_${x}_mutated.txt"
    done

    # Generate DNABERT2 embeddings
    for x in "${types[@]}"; do
        rm -f "${seed_dir}/DNABERT2_lonely.K562_plus_${x}_mutated.csv"

        python3 supp4.embedding.py \
            "${seed_dir}/lonely.K562_plus_${x}_mutated.txt" \
            "${seed_dir}/DNABERT2_lonely.K562_plus_${x}_mutated.csv"
    done

    # Predict mutated sequences
    for x in "${types[@]}"; do
        for i in {00..04}; do
            g4beacon2 getValidatedG4s \
                --seqCSV    "${seed_dir}/DNABERT2_lonely.K562_plus_${x}_mutated.csv" \
                --atacCSV   lonely.K562_plus.atac.csv \
                --originBED lonely.K562_plus.origin.bed \
                --model     "path/to/models/zscoreDNABERT2_HepG2_ES${i}_0517model.checkpoint.joblib" \
                -o "${seed_dir}/HepG2onK562_0.5_ES${i}_plus_${x}_mutated.bed"
        done

        paste \
            "${seed_dir}/HepG2onK562_0.5_ES00_plus_${x}_mutated.bed" \
            "${seed_dir}/HepG2onK562_0.5_ES01_plus_${x}_mutated.bed" \
            "${seed_dir}/HepG2onK562_0.5_ES02_plus_${x}_mutated.bed" \
            "${seed_dir}/HepG2onK562_0.5_ES03_plus_${x}_mutated.bed" \
            "${seed_dir}/HepG2onK562_0.5_ES04_plus_${x}_mutated.bed" \
            | awk '{sum=($4+$8+$12+$16+$20)/5; print $1"\t"$2"\t"$3"\t"sum}' \
            > "${seed_dir}/HepG2onK562_0.5_CellScore_plus_${x}_mutated.bed"
    done

    out="${seed_dir}/merged_scores_plus.tsv"

    files=(
        HepG2onK562_0.5_CellScore_plus.bed
        "${seed_dir}/HepG2onK562_0.5_CellScore_plus_random_mutated.bed"
        "${seed_dir}/HepG2onK562_0.5_CellScore_plus_edge_G_mutated.bed"
        "${seed_dir}/HepG2onK562_0.5_CellScore_plus_center_G_mutated.bed"
    )

    ref="${files[0]}"

    # Ensure all score files are aligned before merging
    for f in "${files[@]:1}"; do
        diff <(cut -f1-3 "$ref") <(cut -f1-3 "$f") > /dev/null || {
            echo "Error: inconsistent genomic coordinates between $ref and $f" >&2
            exit 1
        }
    done

    printf "chr\tstart\tend\toriginal\trandom\tedge_G\tcenter_G\n" > "$out"

    paste \
        <(cut -f1-4 "${files[0]}") \
        <(cut -f4 "${files[1]}") \
        <(cut -f4 "${files[2]}") \
        <(cut -f4 "${files[3]}") \
        >> "$out"
done