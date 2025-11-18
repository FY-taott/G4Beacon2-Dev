#!/bin/bash

NUM_CHR=$1
START=$2
END=$3
OUTPUT=$4


cat > $OUTPUT <<EOF
# --- Standard ---
std
it None
None

# --- Range Definitions ---
EOF

for ((i=1; i<=NUM_CHR; i++)); do
cat >> $OUTPUT <<EOF
chr $i
it None
$START-$END sn 0.5

EOF
done
