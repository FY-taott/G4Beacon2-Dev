paste -d',' HepG2/HepG2_ES00_importance_Seq_ranked.csv \
            HepG2/HepG2_ES01_importance_Seq_ranked.csv \
            HepG2/HepG2_ES02_importance_Seq_ranked.csv \
            HepG2/HepG2_ES03_importance_Seq_ranked.csv \
            HepG2/HepG2_ES04_importance_Seq_ranked.csv \
            H9/H9_ES00_importance_Seq_ranked.csv \
            H9/H9_ES01_importance_Seq_ranked.csv \
            H9/H9_ES02_importance_Seq_ranked.csv \
            H9/H9_ES03_importance_Seq_ranked.csv \
            H9/H9_ES04_importance_Seq_ranked.csv \
            WT26/WT26_ES00_importance_Seq_ranked.csv \
            WT26/WT26_ES01_importance_Seq_ranked.csv \
            WT26/WT26_ES02_importance_Seq_ranked.csv \
            WT26/WT26_ES03_importance_Seq_ranked.csv \
            WT26/WT26_ES04_importance_Seq_ranked.csv \
            > HepG2_H9_WT26_importance_Seq_ranked.csv

awk -F',' 'NR>1 {print $1","($3+$6+$9+$12+$15 + $18+$21+$24+$27+$30 + $33+$36+$39+$42+$45)}' \
    HepG2_H9_WT26_importance_Seq_ranked.csv \
    > HepG2_H9_WT26_importance_Seq_score.csv

sort -t, -k2,2n HepG2_H9_WT26_importance_Seq_score.csv \
                > HepG2_H9_WT26_importance_Seq_score.csv_sorted.csv
