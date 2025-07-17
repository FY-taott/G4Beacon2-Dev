library(keras)
reticulate::use_condaenv("DeepG4")

library(rtracklayer)
library(BSgenome.Hsapiens.UCSC.hg19)
library(DeepG4)

BEDum <- import.bed("K562_ug4_minus_origin_201bp.bed6")
BEDvm <- import.bed("K562_vg4_minus_origin_201bp.bed6")
BEDup <- import.bed("K562_ug4_plus_origin_201bp.bed6")
BEDvp <- import.bed("K562_vg4_plus_origin_201bp.bed6")

ATAC <- import.bw("K562_ATAC_hg19_raw.bigwig")

Input_DeepG4um <- DeepG4InputFromBED(BED=BEDum,ATAC = ATAC,GENOME=BSgenome.Hsapiens.UCSC.hg19)
Input_DeepG4vm <- DeepG4InputFromBED(BED=BEDvm,ATAC = ATAC,GENOME=BSgenome.Hsapiens.UCSC.hg19)
Input_DeepG4up <- DeepG4InputFromBED(BED=BEDup,ATAC = ATAC,GENOME=BSgenome.Hsapiens.UCSC.hg19)
Input_DeepG4vp <- DeepG4InputFromBED(BED=BEDvp,ATAC = ATAC,GENOME=BSgenome.Hsapiens.UCSC.hg19)
#Input_DeepG4

predictions_um <- DeepG4(X=Input_DeepG4um[[1]],X.atac = Input_DeepG4um[[2]])
predictions_vm <- DeepG4(X=Input_DeepG4vm[[1]],X.atac = Input_DeepG4vm[[2]])
predictions_up <- DeepG4(X=Input_DeepG4up[[1]],X.atac = Input_DeepG4up[[2]])
predictions_vp <- DeepG4(X=Input_DeepG4vp[[1]],X.atac = Input_DeepG4vp[[2]])

#head(predictions)

# 保存 predictions 为 txt 文件，不包含行号和列名
write.table(predictions_um, file = "K562_ug4_minus_origin_201bp_predictions.txt", row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")
write.table(predictions_vm, file = "K562_vg4_minus_origin_201bp_predictions.txt", row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")
write.table(predictions_up, file = "K562_ug4_plus_origin_201bp_predictions.txt", row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")
write.table(predictions_vp, file = "K562_vg4_plus_origin_201bp_predictions.txt", row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")

