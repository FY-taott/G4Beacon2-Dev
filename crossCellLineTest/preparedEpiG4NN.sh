cut -f4 K562_ug4_minus_origin_1000bp.bed6 > \
        K562_ug4_minus_origin_1000bp.id
        
cut -f4 K562_ug4_plus_origin_1000bp.bed6 > \
        K562_ug4_plus_origin_1000bp.id

cut -f4 K562_vg4_minus_origin_1000bp.bed6 > \
        K562_vg4_minus_origin_1000bp.id

cut -f4 K562_vg4_plus_origin_1000bp.bed6 > \
        K562_vg4_plus_origin_1000bp.id
        

awk '{print toupper($0)}' \
    K562_ug4_minus_origin_1000bp.id > \
    K562_ug4_minus_origin_1000bp_upper.id

awk '{print toupper($0)}' \
    K562_ug4_plus_origin_1000bp.id > \
    K562_ug4_plus_origin_1000bp_upper.id

awk '{print toupper($0)}' \
    K562_vg4_minus_origin_1000bp.id > \
    K562_vg4_minus_origin_1000bp_upper.id

awk '{print toupper($0)}' \
    K562_vg4_plus_origin_1000bp.id > \
    K562_vg4_plus_origin_1000bp_upper.id
     
      
paste -d',' K562_ug4_minus_origin_1000bp_upper.id \
            K562_ug4_minus_normalized_ATAC_K562_1000bp.csv \
            > ID_K562_ug4_minus_normalized_ATAC_K562_1000bp.csv
            
paste -d',' K562_ug4_plus_origin_1000bp_upper.id \
            K562_ug4_plus_normalized_ATAC_K562_1000bp.csv \
            > ID_K562_ug4_plus_normalized_ATAC_K562_1000bp.csv

paste -d',' K562_vg4_minus_origin_1000bp_upper.id \
            K562_vg4_minus_normalized_ATAC_K562_1000bp.csv \
            > ID_K562_vg4_minus_normalized_ATAC_K562_1000bp.csv

paste -d',' K562_vg4_plus_origin_1000bp_upper.id \
            K562_vg4_plus_normalized_ATAC_K562_1000bp.csv \
            > ID_K562_vg4_plus_normalized_ATAC_K562_1000bp.csv
