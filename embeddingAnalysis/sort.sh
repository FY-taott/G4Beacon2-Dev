tail -n +2 rank_median_pivot.csv > rank_median_pivot_pure.csv 
sort -t, -k2,2n rank_median_pivot_pure.csv > rank_median_sorted.csv