awk 'BEGIN{OFS="\t"} {print $1,$2,$3,".",".",$4}' UpstreamAll_1000shuf.bed4 > UpstreamAll_1000shuf.bed6

bedtools getfasta -fi hg19.fa \
                  -bed UpstreamAll_1000shuf.bed6 \
                  -s \
                  -tab \
                  -fo UpstreamAll_1000shuf.tab

cut -f2 UpstreamAll_1000shuf.tab > UpstreamAll_1000shuf.txt
awk '{print toupper($0)}' UpstreamAll_1000shuf.txt > UpstreamAll_1000shuf_upper.txt
