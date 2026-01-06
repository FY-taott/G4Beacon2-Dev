#!/bin/bash

input_file="TESTNAME_std.atac.csv"
output_file="TESTNAME_std.atac.8000.csv"

> "$output_file"

for i in {1..8000}
do
  cat "$input_file" >> "$output_file"
done
