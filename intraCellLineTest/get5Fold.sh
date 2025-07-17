# number for minus and plus
Nm=1639807
Np=1664342

# index shuffled
seq "$Nm" | shuf > minus_index_all      
split -d -n l/5 minus_index_all minus_index_

seq "$Np" | shuf > plus_index_all      
split -d -n l/5 plus_index_all plus_index_

## for plus
awk 'NR==FNR{a[$1]; next} FNR in a' plus_index_00 sorted_ID_GenomeBins_plus_BED6.bed > GenomeBins_plus_BED6_index00.bed
awk 'NR==FNR{a[$1]; next} FNR in a' plus_index_00 ID_GenomeBins_hg19_plus_seq.csv > GenomeBins_plus_seq_index00.csv
awk 'NR==FNR{a[$1]; next} FNR in a' plus_index_00 ID_GenomeBins_hg19_plus_HepG2_zscore.csv > GenomeBins_plus_HepG2_zscore_index00.csv


awk 'NR==FNR{a[$1]; next} FNR in a' plus_index_01 sorted_ID_GenomeBins_plus_BED6.bed > GenomeBins_plus_BED6_index01.bed
awk 'NR==FNR{a[$1]; next} FNR in a' plus_index_01 ID_GenomeBins_hg19_plus_seq.csv > GenomeBins_plus_seq_index01.csv
awk 'NR==FNR{a[$1]; next} FNR in a' plus_index_01 ID_GenomeBins_hg19_plus_HepG2_zscore.csv > GenomeBins_plus_HepG2_zscore_index01.csv


awk 'NR==FNR{a[$1]; next} FNR in a' plus_index_02 sorted_ID_GenomeBins_plus_BED6.bed > GenomeBins_plus_BED6_index02.bed
awk 'NR==FNR{a[$1]; next} FNR in a' plus_index_02 ID_GenomeBins_hg19_plus_seq.csv > GenomeBins_plus_seq_index02.csv
awk 'NR==FNR{a[$1]; next} FNR in a' plus_index_02 ID_GenomeBins_hg19_plus_HepG2_zscore.csv > GenomeBins_plus_HepG2_zscore_index02.csv


awk 'NR==FNR{a[$1]; next} FNR in a' plus_index_03 sorted_ID_GenomeBins_plus_BED6.bed > GenomeBins_plus_BED6_index03.bed
awk 'NR==FNR{a[$1]; next} FNR in a' plus_index_03 ID_GenomeBins_hg19_plus_seq.csv > GenomeBins_plus_seq_index03.csv
awk 'NR==FNR{a[$1]; next} FNR in a' plus_index_03 ID_GenomeBins_hg19_plus_HepG2_zscore.csv > GenomeBins_plus_HepG2_zscore_index03.csv


awk 'NR==FNR{a[$1]; next} FNR in a' plus_index_04 sorted_ID_GenomeBins_plus_BED6.bed > GenomeBins_plus_BED6_index04.bed
awk 'NR==FNR{a[$1]; next} FNR in a' plus_index_04 ID_GenomeBins_hg19_plus_seq.csv > GenomeBins_plus_seq_index04.csv
awk 'NR==FNR{a[$1]; next} FNR in a' plus_index_04 ID_GenomeBins_hg19_plus_HepG2_zscore.csv > GenomeBins_plus_HepG2_zscore_index04.csv


## for minus
awk 'NR==FNR{a[$1]; next} FNR in a' minus_index_00 sorted_ID_GenomeBins_minus_BED6.bed > GenomeBins_minus_BED6_index00.bed
awk 'NR==FNR{a[$1]; next} FNR in a' minus_index_00 ID_GenomeBins_hg19_minus_seq.csv > GenomeBins_minus_seq_index00.csv
awk 'NR==FNR{a[$1]; next} FNR in a' minus_index_00 ID_GenomeBins_hg19_minus_HepG2_zscore.csv > GenomeBins_minus_HepG2_zscore_index00.csv


awk 'NR==FNR{a[$1]; next} FNR in a' minus_index_01 sorted_ID_GenomeBins_minus_BED6.bed > GenomeBins_minus_BED6_index01.bed
awk 'NR==FNR{a[$1]; next} FNR in a' minus_index_01 ID_GenomeBins_hg19_minus_seq.csv > GenomeBins_minus_seq_index01.csv
awk 'NR==FNR{a[$1]; next} FNR in a' minus_index_01 ID_GenomeBins_hg19_minus_HepG2_zscore.csv > GenomeBins_minus_HepG2_zscore_index01.csv


awk 'NR==FNR{a[$1]; next} FNR in a' minus_index_02 sorted_ID_GenomeBins_minus_BED6.bed > GenomeBins_minus_BED6_index02.bed
awk 'NR==FNR{a[$1]; next} FNR in a' minus_index_02 ID_GenomeBins_hg19_minus_seq.csv > GenomeBins_minus_seq_index02.csv
awk 'NR==FNR{a[$1]; next} FNR in a' minus_index_02 ID_GenomeBins_hg19_minus_HepG2_zscore.csv > GenomeBins_minus_HepG2_zscore_index02.csv


awk 'NR==FNR{a[$1]; next} FNR in a' minus_index_03 sorted_ID_GenomeBins_minus_BED6.bed > GenomeBins_minus_BED6_index03.bed
awk 'NR==FNR{a[$1]; next} FNR in a' minus_index_03 ID_GenomeBins_hg19_minus_seq.csv > GenomeBins_minus_seq_index03.csv
awk 'NR==FNR{a[$1]; next} FNR in a' minus_index_03 ID_GenomeBins_hg19_minus_HepG2_zscore.csv > GenomeBins_minus_HepG2_zscore_index03.csv


awk 'NR==FNR{a[$1]; next} FNR in a' minus_index_04 sorted_ID_GenomeBins_minus_BED6.bed > GenomeBins_minus_BED6_index04.bed
awk 'NR==FNR{a[$1]; next} FNR in a' minus_index_04 ID_GenomeBins_hg19_minus_seq.csv > GenomeBins_minus_seq_index04.csv
awk 'NR==FNR{a[$1]; next} FNR in a' minus_index_04 ID_GenomeBins_hg19_minus_HepG2_zscore.csv > GenomeBins_minus_HepG2_zscore_index04.csv