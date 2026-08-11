# Environment: gkmsvm
K <- 100

dir.create("temp/gennull", recursive=TRUE, showWarnings=FALSE)
suppressPackageStartupMessages({
  library(gkmSVM)
  library(Biostrings)
  library(BSgenome.Hsapiens.UCSC.hg19.masked)
})

for (seed in seq_len(K)) {
  set.seed(seed)
  tag <- sprintf("%03d", seed)
  genNullSeqs(
    inputBedFN="temp/important_986.bed3",
    genomeVersion="hg19",
    outputBedFN=sprintf("temp/gennull/raw_%s.bed", tag),
    outputPosFastaFN=sprintf("temp/gennull/pos_%s.fa", tag),
    outputNegFastaFN=sprintf("temp/gennull/raw_%s.fa", tag),
    xfold=1,
    GC_match_tol=0.02,
    repeat_match_tol=0.02,
    length_match_tol=0,
    batchsize=1000000,
    nMaxTrials=50
  )

  sequences <- readDNAStringSet(sprintf("temp/gennull/raw_%s.fa", tag))
  names(sequences) <- sprintf("IMP_%04d", seq_along(sequences))
  writeXStringSet(sequences, sprintf("temp/gennull/gennull_r%s.fa", tag))
  if (seed %% 10 == 0) cat("genNullSeqs:", seed, "/", K, "\n")
}
