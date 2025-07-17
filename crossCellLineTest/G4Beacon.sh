g4beacon2 getValidatedG4s \
       --seqCSV     K562_ug4_minus_seq.csv \
       --atacCSV    K562_ug4_minus_atac.csv \
       --originBED  K562_ug4_minus_origin.bed \
       --model      rawCode_rawAll_0517model.checkpoint.joblib \
       -o           K562_ug4_minus_G4B1.bed

g4beacon2 getValidatedG4s \
       --seqCSV     K562_ug4_plus_seq.csv \
       --atacCSV    K562_ug4_plus_atac.csv \
       --originBED  K562_ug4_plus_origin.bed \
       --model      rawCode_rawAll_0517model.checkpoint.joblib \
       -o           K562_ug4_plus_G4B1.bed

g4beacon2 getValidatedG4s \
       --seqCSV     K562_vg4_minus_seq.csv \
       --atacCSV    K562_vg4_minus_atac.csv \
       --originBED  K562_vg4_minus_origin.bed \
       --model      rawCode_rawAll_0517model.checkpoint.joblib \
       -o           K562_vg4_minus_G4B1.bed

g4beacon2 getValidatedG4s \
       --seqCSV     K562_vg4_plus_seq.csv \
       --atacCSV    K562_vg4_plus_atac.csv \
       --originBED  K562_vg4_plus_origin.bed \
       --model      rawCode_rawAll_0517model.checkpoint.joblib \
       -o           K562_vg4_plus_G4B1.bed