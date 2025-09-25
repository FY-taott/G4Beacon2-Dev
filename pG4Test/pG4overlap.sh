bedtools intersect -a HepG2Train_K562.bed \
                   -b Predicted_human_G4.bed3 \
                   -c \
                   -F 1.0 \
                   > HepG2Train_K562_PQSfinder_F1.0.bed

bedtools intersect -a HepG2Train_K562_PQSfinder_F1.0.bed \
                   -b GSE187007_hg19_G4H1.52.bed3 \
                   -c \
                   -F 1.0 \
                   > HepG2Train_K562_PQSfinder_G4Hunter_F1.0.bed

bedtools intersect -a HepG2Train_K562_PQSfinder_G4Hunter_F1.0.bed \
                   -b GSE133379_PQS-hg19.bed3 \
                   -c \
                   -F 1.0 \
                   > HepG2Train_K562_PQSfinder_G4Hunter_Gmotif_F1.0.bed

bedtools intersect -a HepG2Train_K562_PQSfinder_G4Hunter_Gmotif_F1.0.bed \
                   -b HG19_thr_0.25_minlen_6.bed3 \
                   -c \
                   -F 1.0 \
                   > HepG2Train_K562_PQSfinder_G4Hunter_Gmotif_GDNABERT_F1.0.bed

bedtools intersect -a HepG2Train_K562_PQSfinder_G4Hunter_Gmotif_GDNABERT_F1.0.bed \
                   -b hg19_gquadruplex_tab.bed3 \
                   -c \
                   -F 1.0 \
                   > HepG2Train_K562_PQSfinder_G4Hunter_Gmotif_GDNABERT_QFS_F1.0.bed