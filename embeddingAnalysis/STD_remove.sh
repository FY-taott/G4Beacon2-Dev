awk '$1 ~ /^chr([1-9]|1[0-9]|2[0-2]|X|Y)$/' UpstreamBy1k_hg19.bed6 > UpstreamBy1k_hg19_STD_raw.bed6
cut -f1-3,6 UpstreamBy1k_hg19_STD_raw.bed6 | sort -k1,1 -k2,2n -k3,3n -k4,4 -u > UpstreamBy1k_hg19_STD_raw.bed4
bedtools intersect -a UpstreamBy1k_hg19_STD_raw.bed4 \
                   -b merged_black_gap.bed \
                   -v \
                   >  UpstreamBy1k_hg19_STD.bed4
