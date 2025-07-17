# +500的原因是bed文件开区间

awk 'BEGIN { OFS="\t" }
{
    mid = int(($2 + $3) / 2);
    start = mid - 500;
    end = mid + 500;
    if (start < 0) start = 0;
    print $1, start, end, $4, $5, $6;
}' /mnt/disk1/tiantong/workspace/2025/0529revision/4.crossCellTest/1.gkmSVM/K562_vg4_minus_origin.bed \
> K562_vg4_minus_origin_1000bp.bed

awk 'BEGIN { OFS="\t" }
{
    mid = int(($2 + $3) / 2);
    start = mid - 500;
    end = mid + 500;
    if (start < 0) start = 0;
    print $1, start, end, $4, $5, $6;
}' /mnt/disk1/tiantong/workspace/2025/0529revision/4.crossCellTest/1.gkmSVM/K562_vg4_plus_origin.bed \
> K562_vg4_plus_origin_1000bp.bed

awk 'BEGIN { OFS="\t" }
{
    mid = int(($2 + $3) / 2);
    start = mid - 500;
    end = mid + 500;
    if (start < 0) start = 0;
    print $1, start, end, $4, $5, $6;
}' /mnt/disk1/tiantong/workspace/2025/0529revision/4.crossCellTest/1.gkmSVM/K562_ug4_minus_origin.bed \
> K562_ug4_minus_origin_1000bp.bed

awk 'BEGIN { OFS="\t" }
{
    mid = int(($2 + $3) / 2);
    start = mid - 500;
    end = mid + 500;
    if (start < 0) start = 0;
    print $1, start, end, $4, $5, $6;
}' /mnt/disk1/tiantong/workspace/2025/0529revision/4.crossCellTest/1.gkmSVM/K562_ug4_plus_origin.bed \
> K562_ug4_plus_origin_1000bp.bed


#

# minus
awk 'BEGIN { OFS="\t" } { $4 = "IDm" FNR; $5 = "."; $6 = "-"; print }' \
    K562_ug4_minus_origin_1000bp.bed \
  > K562_ug4_minus_origin_1000bp.bed6

awk 'BEGIN { OFS="\t" } { $4 = "IDm" FNR; $5 = "."; $6 = "-"; print }' \
    K562_vg4_minus_origin_1000bp.bed \
  > K562_vg4_minus_origin_1000bp.bed6

# plus
awk 'BEGIN { OFS="\t" } { $4 = "IDp" FNR; $5 = "."; $6 = "+"; print }' \
    K562_ug4_plus_origin_1000bp.bed \
  > K562_ug4_plus_origin_1000bp.bed6

awk 'BEGIN { OFS="\t" } { $4 = "IDp" FNR; $5 = "."; $6 = "+"; print }' \
    K562_vg4_plus_origin_1000bp.bed \
  > K562_vg4_plus_origin_1000bp.bed6

# get sequence

bedtools getfasta -fi hg19.fa \
                  -bed K562_ug4_minus_origin_1000bp.bed6 \
                  -s -nameOnly > K562_ug4_minus_origin_1000bp_nameOnly.fasta

bedtools getfasta -fi hg19.fa \
                  -bed K562_ug4_plus_origin_1000bp.bed6 \
                  -s -nameOnly > K562_ug4_plus_origin_1000bp_nameOnly.fasta

bedtools getfasta -fi hg19.fa \
                  -bed K562_vg4_minus_origin_1000bp.bed6 \
                  -s -nameOnly > K562_vg4_minus_origin_1000bp_nameOnly.fasta

bedtools getfasta -fi hg19.fa \
                  -bed K562_vg4_plus_origin_1000bp.bed6 \
                  -s -nameOnly > K562_vg4_plus_origin_1000bp_nameOnly.fasta


# get fasta file prepared for epiG4NN
sed '/^>/s/([+-])//g' \
    K562_vg4_minus_origin_1000bp_nameOnly.fasta \
    > K562_vg4_minus_origin_1000bp_nameOnly_cleaned.fasta
    
awk '{print toupper($0)}' \
    K562_vg4_minus_origin_1000bp_nameOnly_cleaned.fasta \
    > K562_vg4_minus_origin_1000bp_nameOnly_cleaned_upper.fasta

sed '/^>/s/([+-])//g' \
    K562_vg4_plus_origin_1000bp_nameOnly.fasta \
    > K562_vg4_plus_origin_1000bp_nameOnly_cleaned.fasta
    
awk '{print toupper($0)}' \
    K562_vg4_plus_origin_1000bp_nameOnly_cleaned.fasta \
    > K562_vg4_plus_origin_1000bp_nameOnly_cleaned_upper.fasta

sed '/^>/s/([+-])//g' \
    K562_ug4_minus_origin_1000bp_nameOnly.fasta \
    > K562_ug4_minus_origin_1000bp_nameOnly_cleaned.fasta
    
awk '{print toupper($0)}' \
    K562_ug4_minus_origin_1000bp_nameOnly_cleaned.fasta \
    > K562_ug4_minus_origin_1000bp_nameOnly_cleaned_upper.fasta


sed '/^>/s/([+-])//g' \
    K562_ug4_plus_origin_1000bp_nameOnly.fasta \
    > K562_ug4_plus_origin_1000bp_nameOnly_cleaned.fasta
    
awk '{print toupper($0)}' \
    K562_ug4_plus_origin_1000bp_nameOnly_cleaned.fasta \
    > K562_ug4_plus_origin_1000bp_nameOnly_cleaned_upper.fasta

# get ATAC matrix
computeMatrix reference-point \
    --referencePoint center \
    -R K562_vg4_minus_origin_1000bp.bed \
    -S normalized_K562_ATAC_hg19_raw.bigwig \
    -p 24 \
    -a 500 -b 500 -bs 1 \
    --outFileName K562_vg4_minus_normalized_ATAC_K562_1000bp.plot \
    --outFileNameMatrix K562_vg4_minus_normalized_ATAC_K562_1000bp.matrix

computeMatrix reference-point \
    --referencePoint center \
    -R K562_vg4_plus_origin_1000bp.bed \
    -S normalized_K562_ATAC_hg19_raw.bigwig \
    -p 24 \
    -a 500 -b 500 -bs 1 \
    --outFileName K562_vg4_plus_normalized_ATAC_K562_1000bp.plot \
    --outFileNameMatrix K562_vg4_plus_normalized_ATAC_K562_1000bp.matrix


computeMatrix reference-point \
    --referencePoint center \
    -R K562_ug4_minus_origin_1000bp.bed \
    -S normalized_K562_ATAC_hg19_raw.bigwig \
    -p 24 \
    -a 500 -b 500 -bs 1 \
    --outFileName K562_ug4_minus_normalized_ATAC_K562_1000bp.plot \
    --outFileNameMatrix K562_ug4_minus_normalized_ATAC_K562_1000bp.matrix

computeMatrix reference-point \
    --referencePoint center \
    -R K562_ug4_plus_origin_1000bp.bed \
    -S normalized_K562_ATAC_hg19_raw.bigwig \
    -p 24 \
    -a 500 -b 500 -bs 1 \
    --outFileName K562_ug4_plus_normalized_ATAC_K562_1000bp.plot \
    --outFileNameMatrix K562_ug4_plus_normalized_ATAC_K562_1000bp.matrix
