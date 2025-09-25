cd HepG2onA549

FILE_PREFIX="HepG2onA549_BinsNotFromOG4"

## withouto oG4 : not validated. Label 0
for i in {00..04}; do
    sort -k1,1 -k2,2n -u "${FILE_PREFIX}_ES${i}_plus.bed" > "sorted_${FILE_PREFIX}_ES${i}_plus.bed"
    sort -k1,1 -k2,2n -u "${FILE_PREFIX}_ES${i}_minus.bed" > "sorted_${FILE_PREFIX}_ES${i}_minus.bed"
    
    awk '{print $0 "\t0"}' "sorted_${FILE_PREFIX}_ES${i}_plus.bed" > "${FILE_PREFIX}_ES${i}_plus_eval_0.bed"
    awk '{print $0 "\t0"}' "sorted_${FILE_PREFIX}_ES${i}_minus.bed" > "${FILE_PREFIX}_ES${i}_minus_eval_0.bed"
    
    cat "${FILE_PREFIX}_ES${i}_plus_eval_0.bed" \
        "${FILE_PREFIX}_ES${i}_minus_eval_0.bed" \
        > "${FILE_PREFIX}_ES${i}_eval.bed"
done

paste "${FILE_PREFIX}_ES00_eval.bed" \
      "${FILE_PREFIX}_ES01_eval.bed" \
      "${FILE_PREFIX}_ES02_eval.bed" \
      "${FILE_PREFIX}_ES03_eval.bed" \
      "${FILE_PREFIX}_ES04_eval.bed" \
      | awk '{sum=($4+$9+$14+$19+$24)/5; print $1"\t"$2"\t"$3"\t"sum"\t"$5}' \
      > "${FILE_PREFIX}_ensemble.bed"

