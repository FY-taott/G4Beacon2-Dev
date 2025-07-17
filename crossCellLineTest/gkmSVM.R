library('gkmSVM')

genNullSeqs(
  'K562_vg4_plus_origin.bed',
  outputBedFN = 'K562_ug4gkm_plus_origin.bed',
  outputPosFastaFN = 'plus_vg4.fa',
  outputNegFastaFN = 'plus_ug4.fa',
  xfold=2,
  batchsize=100000)
  
genNullSeqs(
  'K562_vg4_minus_origin.bed',
  outputBedFN = 'K562_ug4gkm_minus_origin.bed',
  outputPosFastaFN = 'minus_vg4.fa',
  outputNegFastaFN = 'minus_ug4.fa',
  xfold=2,
  batchsize=100000)
  