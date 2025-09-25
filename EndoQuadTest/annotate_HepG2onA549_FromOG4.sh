mkdir HepG2onA549
cd HepG2onA549

G4_PATH="A549_intersection.bed"
FILE_PREFIX="HepG2onA549_BinsFromOG4"


for i in {00..04}; do
    bedtools intersect -a "${FILE_PREFIX}_ES${i}_plus.bed" \
                       -b "$G4_PATH" \
                       -wa -F 0.1 | sort -k1,1 -k2,2n -u > "${FILE_PREFIX}_ES${i}_plus_1.bed"

    bedtools intersect -a "${FILE_PREFIX}_ES${i}_plus.bed" \
                       -b "$G4_PATH" \
                       -v -F 0.1 | sort -k1,1 -k2,2n -u > "${FILE_PREFIX}_ES${i}_plus_0.bed"

    bedtools intersect -a "${FILE_PREFIX}_ES${i}_minus.bed" \
                       -b "$G4_PATH" \
                       -wa -F 0.1 | sort -k1,1 -k2,2n -u > "${FILE_PREFIX}_ES${i}_minus_1.bed"

    bedtools intersect -a "${FILE_PREFIX}_ES${i}_minus.bed" \
                       -b "$G4_PATH" \
                       -v -F 0.1 | sort -k1,1 -k2,2n -u > "${FILE_PREFIX}_ES${i}_minus_0.bed"
                    

awk '{print $0 "\t1"}' "${FILE_PREFIX}_ES${i}_plus_1.bed" > "${FILE_PREFIX}_ES${i}_plus_eval_1.bed"
awk '{print $0 "\t1"}' "${FILE_PREFIX}_ES${i}_minus_1.bed" > "${FILE_PREFIX}_ES${i}_minus_eval_1.bed"
awk '{print $0 "\t0"}' "${FILE_PREFIX}_ES${i}_plus_0.bed" > "${FILE_PREFIX}_ES${i}_plus_eval_0.bed"
awk '{print $0 "\t0"}' "${FILE_PREFIX}_ES${i}_minus_0.bed" > "${FILE_PREFIX}_ES${i}_minus_eval_0.bed"

cat "${FILE_PREFIX}_ES${i}_plus_eval_1.bed" \
    "${FILE_PREFIX}_ES${i}_minus_eval_1.bed" \
    "${FILE_PREFIX}_ES${i}_plus_eval_0.bed" \
    "${FILE_PREFIX}_ES${i}_minus_eval_0.bed" > "${FILE_PREFIX}_ES${i}_eval.bed"
done

paste "${FILE_PREFIX}_ES00_eval.bed" \
      "${FILE_PREFIX}_ES01_eval.bed" \
      "${FILE_PREFIX}_ES02_eval.bed" \
      "${FILE_PREFIX}_ES03_eval.bed" \
      "${FILE_PREFIX}_ES04_eval.bed" \
      | awk '{sum=($4+$9+$14+$19+$24)/5; print $1"\t"$2"\t"$3"\t"sum"\t"$5}' \
      > "${FILE_PREFIX}_ensemble.bed"
