file1=$1
file2=$2
output=$3

cat $file1 $file2 > file.bed
bedtools sort -i file.bed > sorted_file.bed
bedtools merge -i sorted_file.bed > $output
rm file.bed sorted_file.bed