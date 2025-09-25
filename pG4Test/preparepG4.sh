#g4hunter
cut -f1-3 GSE187007_hg19_G4H1.52.bed > GSE187007_hg19_G4H1.52.bed3

#gdnabert
awk 'BEGIN{OFS="\t"}{$1=$1; print}'  HG19_thr_0.25_minlen_6.bed > HG19_thr_0.25_minlen_6.bed3

#g4motif
bigBedToBed GSE133379_PQS-hg19.BigBed GSE133379_PQS-hg19.bed
cut -f1-3 GSE133379_PQS-hg19.bed > GSE133379_PQS-hg19.bed3

#pqs
awk '{print $1, $2, $3}' FS='\t' OFS='\t' \
    Predicted_human_G4.txt \
    | tail -n +2 > Predicted_human_G4.bed3

#qfs
awk 'BEGIN{OFS="\t"}{$1=$1; print}'  \
    hg19_gquadruplex.bed \
    > hg19_gquadruplex_tab.bed

cut -f1-3 hg19_gquadruplex_tab.bed | tail -n +3 > hg19_gquadruplex_tab.bed3