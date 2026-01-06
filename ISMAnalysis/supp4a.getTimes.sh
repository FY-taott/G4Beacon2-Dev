#!/bin/bash

input_file="TESTNAME_std.origin.bed"
output_file="TESTNAME_std.origin.8000.bed"

> "$output_file"

for i in {1..8000}
do
  cat "$input_file" >> "$output_file"
done
