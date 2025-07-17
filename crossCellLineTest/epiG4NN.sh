python predict.py \
       --seqs K562_vg4_minus_origin_1000bp_nameOnly_cleaned_upper.fasta \
       --epi ID_K562_vg4_minus_normalized_ATAC_K562_1000bp.csv \
       --model atac \
       --output K562_vg4_minus

python predict.py \
       --seqs K562_vg4_plus_origin_1000bp_nameOnly_cleaned_upper.fasta \
       --epi ID_K562_vg4_plus_normalized_ATAC_K562_1000bp.csv \
       --model atac \
       --output K562_vg4_plus
       
python predict.py \
       --seqs K562_ug4_minus_origin_1000bp_nameOnly_cleaned_upper.fasta \
       --epi ID_K562_ug4_minus_normalized_ATAC_K562_1000bp.csv \
       --model atac \
       --output K562_ug4_minus

python predict.py \
       --seqs K562_ug4_plus_origin_1000bp_nameOnly_cleaned_upper.fasta \
       --epi ID_K562_ug4_plus_normalized_ATAC_K562_1000bp.csv \
       --model atac \
       --output K562_ug4_plus
       
