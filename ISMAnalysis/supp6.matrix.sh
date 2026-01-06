#!/bin/bash

input_file="TESTNAME_std_predicion_CellScore_ISM.bed"
output_file="output.tsv"

awk '{print $4}' "$input_file" | paste - - - - | awk 'BEGIN{print "A\tC\tG\tT"} {print $1"\t"$2"\t"$3"\t"$4}' > "$output_file"
