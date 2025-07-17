cut -f 1-3 HepG2_hg38.bedGraph > HepG2_hg38_cut.temp
awk '{printf "%.6g\n", $2}' HepG2_hg38_z_score_normalized.bedgraph > HepG2_hg38_zscore.temp
paste -d'\t' HepG2_hg38_cut.temp HepG2_hg38_zscore.temp > HepG2_hg38_zscore.bedGraph

bedGraphToBigWig HepG2_hg38_zscore.bedGraph chrom.sizes HepG2_hg38_zscore.bigwig

CrossMap.py bigwig hg38ToHg19.over.chain.gz HepG2_hg38_zscore.bigwig HepG2_ATAC_hg19_zscore.bigwig