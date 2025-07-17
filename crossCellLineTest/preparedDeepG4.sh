# get 201bp
awk 'BEGIN { OFS="\t" }
{
    mid = int(($2 + $3) / 2);
    start = mid - 100;
    end = mid + 101;
    if (start < 0) start = 0;
    print $1, start, end, $4, $5, $6;
}' K562_vg4_minus_origin.bed \
> K562_vg4_minus_origin_201bp.bed


awk 'BEGIN { OFS="\t" }
{
    mid = int(($2 + $3) / 2);
    start = mid - 100;
    end = mid + 101;
    if (start < 0) start = 0;
    print $1, start, end, $4, $5, $6;
}' K562_vg4_plus_origin.bed \
> K562_vg4_plus_origin_201bp.bed


awk 'BEGIN { OFS="\t" }
{
    mid = int(($2 + $3) / 2);
    start = mid - 100;
    end = mid + 101;
    if (start < 0) start = 0;
    print $1, start, end, $4, $5, $6;
}' K562_ug4_minus_origin.bed \
> K562_ug4_minus_origin_201bp.bed


awk 'BEGIN { OFS="\t" }
{
    mid = int(($2 + $3) / 2);
    start = mid - 100;
    end = mid + 101;
    if (start < 0) start = 0;
    print $1, start, end, $4, $5, $6;
}' K562_ug4_plus_origin.bed \
> K562_ug4_plus_origin_201bp.bed

# get strands
awk 'BEGIN { OFS="\t" } { $4 = "."; $5 = "."; $6 = "-"; print }' K562_ug4_minus_origin_201bp.bed > K562_ug4_minus_origin_201bp.bed6
awk 'BEGIN { OFS="\t" } { $4 = "."; $5 = "."; $6 = "-"; print }' K562_vg4_minus_origin_201bp.bed > K562_vg4_minus_origin_201bp.bed6

awk 'BEGIN { OFS="\t" } { $4 = "."; $5 = "."; $6 = "+"; print }' K562_ug4_plus_origin_201bp.bed > K562_ug4_plus_origin_201bp.bed6
awk 'BEGIN { OFS="\t" } { $4 = "."; $5 = "."; $6 = "+"; print }' K562_vg4_plus_origin_201bp.bed > K562_vg4_plus_origin_201bp.bed6


