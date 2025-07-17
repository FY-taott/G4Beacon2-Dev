# G4Beacon2-Dev

This repository contains the source code for G4Beacon2, covering key processes such as training, testing, and analysis, and is available for reference by researchers.

## Contents
- [0. User Guide](#0-user-guide)
- [1. Environment Setup](#1-environment-setup)
- [2. Dataset Construction](#2-dataset-construction)
- [3. Intra-cell-line Test](#3-intra-cell-line-test)
- [4. Cross-cell-line-Test](#4-cross-cell-line-test)
- [5. Multi-level Ensemble](#5-multi-level-ensemble)



## 0. User Guide
We would like to provide two important clarifications here. First, we will explain the guidelines for including code in this repository to ensure there are no misunderstandings during its use. Then, we will offer some recommendations to help ensure the code functions as intended and delivers the expected results.

```
# Guidelines
```
1. We strive to be `concise`. For instance, results from running the same process on different cell lines are omitted, as we consider such repetitions redundant. For example, the workflow trained on HepG2 can be easily replicated by substituting HepG2 data with K562 input. We assume that researchers with a basic understanding of scientific practice will be able to replicate experiments based on a single case.
2. We focus on the `core` aspects of the study. All code essential for understanding G4Beacon2, including processes like intra-cell-line test, cross-cell-line test, and multi-level ensemble, is included. However, basic usage of simpler bioinformatics tools (such as IGV) and basic chart (like a pie chart) creation is selectively omitted to enhance readability, as we believe it does not impact the understanding of researchers.
3. We aim for all referenced data to be accessible by reviewers. In the following code, with the exception of certain datasets named in the ENCODE format (e.g., ENCFF255WFR.bigWig), which require independent retrieval, all other data can be accessed and downloaded from the data folder of [G4Beacon2](https://github.com/FY-taott/G4Beacon2/) or directly from the [G4Beacon2PreEmbedding](https://huggingface.co/datasets/FY-taott/G4Beacon2PreEmbedding) webpage. For a more detailed description of the data sources, please refer to the G4Beacon2 publication (a link will be provided upon publication).


```
# Recommendations
```
1. We recommend using separate `virtual environments` when switching software, especially when conda indicates environment conflicts or potential version overwrites. For example, installing a newer version of matplotlib may alter sklearn's version dependencies, so we prefer creating a dedicated virtual environment for matplotlib to avoid unexpected results during model training.
2. We suggest running shell commands with `bash xxx.sh` instead of `sh xxx.sh`. This approach helps resolve ambiguities and improves compatibility on specific devices.

## 1. Environment Setup
First, we need to download and install [G4Beacon2](https://github.com/FY-taott/G4Beacon2/) and complete the basic environment setup.
```
$ conda create -n G4Beacon2
$ conda activate G4Beacon2

$ git clone https://github.com/FY-taott/G4Beacon2.git
$ cd G4Beacon2/
$ python setup.py install
$ python setup.py install --user # when permission denied
$ pip install -r requirements.txt
```
Please ensure that you follow the package versions specified in the `requirements.txt` file. If installing new software with conda later alters existing package versions, we recommend creating a `new virtual environment` rather than modifying the G4Beacon2 environment.



## 2. Dataset Construction
### 2.1 Identification of oG4 and vG4
Merge and integrate the existing oG4 data, using it as the basis for further analysis.

```bash
# Use the script to combine the oG4 data, using the positive strand as an example.
bash catsortmerge.sh G4seq1_K_plus.bed G4seq1_PDS_plus.bed G4seq1_plus.bed
bash catsortmerge.sh G4seq2_K_plus.bed G4seq2_PDS_plus.bed G4seq2_plus.bed
bash catsortmerge.sh G4seq1_plus.bed G4seq2_plus.bed G4seqs_plus.bed
bash catsortmerge.sh G4seqs_plus.bed MG4_plus.bed G4seqsMG4_plus.bed

# Extend the regions by 50 bp on both sides.
bedtools slop -i G4seqsMG4_plus.bed \
              -g hg19.fa.fai \
              -b 50 \
              > G4seqsMG4_plus_slop50.bed

# Validate the oG4 data on the AG4 of a specific cell line to derive vG4, using HepG2 as an example.
bash overlap10_HepG2.sh
```


### 2.2 Generation of GenomeBins
Generate genomic windows across the entire hg19 genome.
```bash
# Generate windows based on the reference, including only chr1-22/X/Y.
bedtools makewindows -g hg19_pure.chrom.sizes -w 2000 > hg19_pure_w2k.bed

# Remove the blacklist regions, GAP regions, and G4 regions.
# The remaining regions and the oG4 Dataset are the two components of the Genome Bins.
bash removeRegions.sh
```



### 2.3 DNABERT2 Embedding
Perform sequence embedding using DNABERT2.
```bash
# The model loading path and input/output filenames can be modified in DNABERT2.py.
conda activate DNABERT2
python3 DNABERT2.py
```


### 2.4 z-score normalization
Perform Z-score normalization on the ATAC bigwig file.
```bash
# Convert the ATAC-seq p-value bigwig file to wig format, then generate a bedGraph file
bigWigToWig ENCFF255WFR.bigWig HepG2_hg38.wig
wig2bed < HepG2_hg38.wig > HepG2_hg38.bed
cut -f 1,2,3,5- HepG2_hg38.bed > HepG2_hg38.bedGraph

# Obtain the final file.
python3 bwnorm.py HepG2_hg38.bedGraph
bash bdg2bw.sh
bash getATAC.sh
```

## 3. Intra-cell-line Test
### 3.1 Benchmark
```bash
# This section is designed to generate the labeled benchmark.
bash getBenchmark.sh

# This section is designed to generate 5-fold dataset.
bash get5Fold.sh
```

### 3.2 Train and Test
```bash
# This section converts the previous dataset into the input format required by G4Beacon2.
bash dividePosNeg.sh

# Training WITH and WITHOUT ensemble.
bash train.sh

# Predicting WITH and WITHOUT ensemble.
bash predict.sh
```

## 4. Cross-cell-line Test
In our paper, we constructed distinct benchmarks for testing(4.1). Here, we use the ```gkmSVM``` benchmark as a representative example to thoroughly demonstrate our training and testing methodology(4.2&4.3). To apply a different benchmark, one needs only follow the procedures outlined in [2. Dataset Construction](#2-dataset-construction) to generate the corresponding data and replicate the experiment.

### 4.1 Benchmark
Given the scarcity and imbalance of positive samples, the benchmark generation strategy is designed to create various negative samples based on the limited positive samples. The first method treats all non-positive samples in GenomeBins as negative samples, as demonstrated in the previous section. The second method involves generating negative samples using different approaches, including the gkmSVM method, random sampling, and PQS-based random sampling (where negative samples are randomly selected near PQS regions).
```bash
# Generating information for the K562 cell line.
bash overlap10_K562.sh

# gkmSVM
Rscript gkmSVM.R

# random
bash random.sh

# PQS-random
bash PQSrandom.sh
```

### 4.2 Test
All models used here are those published in the [G4Beacon2](https://github.com/FY-taott/G4Beacon2/) GitHub repository, so no training process is involved.
```bash
# negative samples processing
bash standard.sh

# predicting
bash predict.sh
```

### 4.3 Other Tools
```bash
# DeepG4
bash preparedDeepG4.sh
Rscript DeepG4.R

# epiG4NN
bash getSeqATAC.sh
python3 matrix2csv.py
bash preparedEpiG4NN.sh
bash epiG4NN.sh

# G4Beacon
# G4Beacon2 is partially compatible with G4Beacon. Therefore, G4Beacon can run by installing only G4Beacon2, with DNABERT2, z-score, and ensemble methods disabled.
bash G4Beacon.sh
```

## 5. Multi-level Ensemble
```bash
# Grid search validation code based on the K562C cell line.
bash grid.sh

# final used 4:4:1
# $4,$8,$12 are the columns containing the prediction scores.
# If the BED file has additional information,
# please make sure to adjust and verify accordingly.

HepG2para=4
WT26para=4
H9para=1

paste H9onK562_CellScore.bed HepG2onK562_CellScore.bed WT26onK562_CellScore.bed | \
    awk -v h9=$H9para -v hep=$HepG2para -v WT26=$WT26para -v \
    '{power=exp((log($4)*h9 + log($8)*hep + log($12)*WT26)/(h9 + hep + WT26)); \
    print $1"\t"$2"\t"$3"\t"power"\t"$5}' \
    > $output_folder/FusionScore_K562.bed
```
