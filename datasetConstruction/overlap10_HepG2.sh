mkdir HepG2
cd HepG2

bedtools intersect -a ../../0.checkNdata/2.usedData/G4seqsMG4_plus_slop50.bed \
                    -b ../../0.checkNdata/2.usedData/sorted_HepG2_hg19.bed \
                    -wa -F 0.1 | sort -k1,1 -k2,2n -u > plus.g4seqFirst.F0.1.bed &&

bedtools intersect -a ../../0.checkNdata/2.usedData/G4seqsMG4_plus_slop50.bed \
                    -b ../../0.checkNdata/2.usedData/sorted_HepG2_hg19.bed \
                    -v -F 0.1 | sort -k1,1 -k2,2n -u > plus_v.g4seqFirst.F0.1.bed &&

bedtools intersect -a ../../0.checkNdata/2.usedData/G4seqsMG4_minus_slop50.bed \
                    -b ../../0.checkNdata/2.usedData/sorted_HepG2_hg19.bed \
                    -wa -F 0.1 | sort -k1,1 -k2,2n -u > minus.g4seqFirst.F0.1.bed &&

bedtools intersect -a ../../0.checkNdata/2.usedData/G4seqsMG4_minus_slop50.bed \
                    -b ../../0.checkNdata/2.usedData/sorted_HepG2_hg19.bed \
                    -v -F 0.1 | sort -k1,1 -k2,2n -u > minus_v.g4seqFirst.F0.1.bed

g4beacon2 seqFeatureConstruct \
    -i plus.g4seqFirst.F0.1.bed \
    -oseq plus.g4seqFirst.F0.1.ex1000.seq.csv \
    -obi plus.g4seqFirst.F0.1.ex1000.origin.bed \
    -fi ../../0.checkNdata/2.usedData/hg19.fa \
    &&

g4beacon2 seqFeatureConstruct \
    -i plus_v.g4seqFirst.F0.1.bed \
    -oseq plus_v.g4seqFirst.F0.1.ex1000.seq.csv \
    -obi plus_v.g4seqFirst.F0.1.ex1000.origin.bed \
    -fi ../../0.checkNdata/2.usedData/hg19.fa \
    &&

g4beacon2 seqFeatureConstruct \
    -i minus.g4seqFirst.F0.1.bed \
    -oseq minus.g4seqFirst.F0.1.ex1000.seq.csv \
    -obi minus.g4seqFirst.F0.1.ex1000.origin.bed \
    -fi ../../0.checkNdata/2.usedData/hg19.fa \
    --reverse &&

g4beacon2 seqFeatureConstruct \
    -i minus_v.g4seqFirst.F0.1.bed \
    -oseq minus_v.g4seqFirst.F0.1.ex1000.seq.csv \
    -obi minus_v.g4seqFirst.F0.1.ex1000.origin.bed \
    -fi ../../0.checkNdata/2.usedData/hg19.fa \
    --reverse

# raw sequence file in CSV format (same with g4beacon: vg4 is positive)
cat plus.g4seqFirst.F0.1.ex1000.seq.csv minus.g4seqFirst.F0.1.ex1000.seq.csv > vg4_seq.csv
cat plus_v.g4seqFirst.F0.1.ex1000.seq.csv minus_v.g4seqFirst.F0.1.ex1000.seq.csv > ug4_seq.csv

awk -F, 'BEGIN {OFS=""; map="ACGT"} {for (i=1; i<=NF; i++) printf "%s", substr(map, $i+1, 1); print ""}' ug4_seq.csv > ug4_seq.txt
awk -F, 'BEGIN {OFS=""; map="ACGT"} {for (i=1; i<=NF; i++) printf "%s", substr(map, $i+1, 1); print ""}' vg4_seq.csv > vg4_seq.txt