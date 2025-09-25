awk 'BEGIN { OFS="\t" }
{
    mid = int(($2 + $3) / 2);
    start = mid - 500;
    end = mid + 500;
    if (start < 0) start = 0;
    print $1, start, end, $4, $5, $6;
}' ExonsAll_1000shuf.bed6 > ExonsAll_1kbScale.bed


awk 'BEGIN { OFS="\t" }
{
    mid = int(($2 + $3) / 2);
    start = mid - 500;
    end = mid + 500;
    if (start < 0) start = 0;
    print $1, start, end, $4, $5, $6;
}' IntronsAll_1000shuf.bed6 > IntronsAll_1kbScale.bed

