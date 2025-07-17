#!/bin/bash
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 HepG2para mm10para H9para"
    exit 1
fi

HepG2para=$1
mm10para=$2
H9para=$3

output_folder="pow_${HepG2para}.${mm10para}.${H9para}"
mkdir -p $output_folder

paste ../H9Train_K562.bed ../HepG2Train_K562.bed ../mm10Train_K562.bed ../K562CTrain_K562.bed ../MCF7Train_K562.bed | \
    awk -v h9=$H9para -v hep=$HepG2para -v mm10=$mm10para '{
        power=exp((log($4)*h9 + log($9)*hep + log($14)*mm10) / (h9 + hep + mm10))
        print $1"\t"$2"\t"$3"\t"power"\t"$5
    }' > $output_folder/new_merge_K562.bed

paste ../H9Train_K562C.bed ../HepG2Train_K562C.bed ../K562Train_K562C.bed ../mm10Train_K562C.bed ../MCF7Train_K562C.bed | \
    awk -v h9=$H9para -v hep=$HepG2para -v mm10=$mm10para '{
        power=exp((log($4)*h9 + log($9)*hep + log($19)*mm10) / (h9 + hep + mm10))
        print $1"\t"$2"\t"$3"\t"power"\t"$5
    }' > $output_folder/new_merge_K562C.bed

paste ../H9Train_MCF7.bed ../HepG2Train_MCF7.bed ../K562Train_MCF7.bed ../K562CTrain_MCF7.bed ../mm10Train_MCF7.bed | \
    awk -v h9=$H9para -v hep=$HepG2para -v mm10=$mm10para '{
        power=exp((log($4)*h9 + log($9)*hep + log($24)*mm10) / (h9 + hep + mm10))
        print $1"\t"$2"\t"$3"\t"power"\t"$5
    }' > $output_folder/new_merge_MCF7.bed

