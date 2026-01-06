#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import vizsequence


def read_acgt_tsv(tsv_path: str) -> pd.DataFrame:
    try:
        df = pd.read_csv(tsv_path, sep="\t")
        if df.shape[1] == 1:
            df = pd.read_csv(tsv_path, sep=r"\s+", engine="python")
    except Exception:
        df = pd.read_csv(tsv_path, sep=r"\s+", engine="python")

    df = df[["A", "C", "G", "T"]].astype(float)
    return df


def read_single_line_sequence(seq_path: str) -> str:
    with open(seq_path, "r", encoding="utf-8") as f:
        seq = f.readline().strip().upper()
    if not seq:
        raise ValueError(f"Empty sequence in {seq_path}")
    return seq


def onehot_encode_sequence(seq: str) -> np.ndarray:
    base_to_idx = {"A": 0, "C": 1, "G": 2, "T": 3}
    onehot = np.zeros((len(seq), 4), dtype=float)
    for i, b in enumerate(seq):
        if b not in base_to_idx:
            raise ValueError(f"Invalid base '{b}' at position {i}.")
        onehot[i, base_to_idx[b]] = 1.0
    return onehot


def main():
    TSV_PATH = "output.tsv"
    SEQ_PATH = "TESTNAME_std.oseq.txt"
    ####
    ref = NULL

    # This interface is designed to facilitate parallel analysis in future applications.
    SEQ_IDX = 0
    TASK_IDX = 0

    df = read_acgt_tsv(TSV_PATH)
    fast_ism_out_2d = df.to_numpy()  # (L,4)
    L = fast_ism_out_2d.shape[0]

    seq = read_single_line_sequence(SEQ_PATH)
    if len(seq) != L:
        raise ValueError(f"Sequence length ({len(seq)}) != TSV rows ({L}).")
    onehot_sequences = onehot_encode_sequence(seq)[np.newaxis, :, :]  # (1,L,4)

    fast_ism_out = fast_ism_out_2d[np.newaxis, :, np.newaxis, :]

    # ====== 1) mut_minus_ref = fast_ism_out - ref ======
    mut_minus_ref = fast_ism_out - ref

    # ====== euclidean distance======
    # euclidean distance from reference for each output at each position
    mut_minus_ref_euclidean = np.sqrt(np.sum(np.square(mut_minus_ref), -1) / 3)

    # Zoom in heatmap of base x position
    ZOOM_IN = range(1, 1999)

    plt.figure(figsize=(40,5))
    to_plot = mut_minus_ref[SEQ_IDX, ZOOM_IN, TASK_IDX].T
    sns.heatmap(to_plot,
                center=0,
                vmin = np.quantile(to_plot, 0.0001),
                vmax = np.quantile(to_plot, 0.9999),
                xticklabels = 10,
                yticklabels = ['A','C','G','T'],
                cbar_kws = dict(use_gridspec=False,location="top"))
    plt.savefig("TESTNAME_std_0001_1999_HEATMAP_DATE.png",dpi=300)
    plt.show()

    plt.figure(figsize=(40,2))
    plt.plot(mut_minus_ref_euclidean[SEQ_IDX, ZOOM_IN, TASK_IDX])
    plt.margins(0.01, 0.01)
    plt.savefig("TESTNAME_std_0001_1999_ISMSCORE_DATE.png",dpi=300)
    plt.show()

    vizsequence.plot_weights(
          np.expand_dims(mut_minus_ref_euclidean[SEQ_IDX, ZOOM_IN, TASK_IDX], -1)*onehot_sequences[SEQ_IDX, ZOOM_IN],
          figsize=(40,2))
    plt.savefig("TESTNAME_std_0001_1999_LOGO_DATE.png",dpi=300)
    plt.show()


if __name__ == "__main__":
    main()
