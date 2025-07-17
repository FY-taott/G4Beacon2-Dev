# Construct the chromatin-accessibility feature
g4beacon2 atacFeatureConstruct \
       -p          24 \
       --g4Input   BinsFromOG4_hg19_minus_origin.bed \
       --envInput  HepG2_ATAC_hg19_zscore.bigwig \
       --csvOutput BinsFromOG4_hg19_minus_HepG2_zscore.csv

g4beacon2 atacFeatureConstruct \
       -p          24 \
       --g4Input   BinsFromOG4_hg19_plus_origin.bed \
       --envInput  HepG2_ATAC_hg19_zscore.bigwig \
       --csvOutput BinsFromOG4_hg19_plus_HepG2_zscore.csv

g4beacon2 atacFeatureConstruct \
       -p          24 \
       --g4Input   BinsNotFromOG4_hg19_minus_origin.bed \
       --envInput  HepG2_ATAC_hg19_zscore.bigwig \
       --csvOutput BinsNotFromOG4_hg19_minus_HepG2_zscore.csv

g4beacon2 atacFeatureConstruct \
       -p          24 \
       --g4Input   BinsNotFromOG4_hg19_plus_origin.bed \
       --envInput  HepG2_ATAC_hg19_zscore.bigwig \
       --csvOutput BinsNotFromOG4_hg19_plus_HepG2_zscore.csv

