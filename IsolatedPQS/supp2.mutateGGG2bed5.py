import random
import re
import os

bed = "lonely.K562_plus.bed"

types = [
    "random",
    "edge_G",
    "center_G"
]


def random_h():
    return random.choice("ACT")


def random_base_except(base):
    base = base.upper()
    return random.choice([x for x in "ACGT" if x != base])


def find_gruns(seq):
    return [
        (m.start(), len(m.group()))
        for m in re.finditer(r"G+", seq)
        if len(m.group()) >= 3
    ]


def center_pos(start, length):
    if length % 2 == 1:
        return start + length // 2

    return random.choice([
        start + length // 2 - 1,
        start + length // 2
    ])


for seed in range(1, 11):
    random.seed(seed)

    outdir = f"seed{seed}"
    os.makedirs(outdir, exist_ok=True)

    outs = {
        t: open(os.path.join(outdir, bed.replace(".bed", f"_{t}.bed5")), "w")
        for t in types
    }

    for line in open(bed):
        if not line.strip() or line.startswith("#"):
            continue

        a = line.strip().split()
        seq = a[3].upper()

        runs = find_gruns(seq)
        n_run = len(runs)

        s = {t: list(seq) for t in types}

        # random:
        if n_run > 0:
            for pos in random.sample(range(len(seq)), n_run):
                s["random"][pos] = random_base_except(seq[pos])

        # edge_G / center_G:
        for i, n in runs:
            s["edge_G"][random.choice([i, i + n - 1])] = random_h()
            s["center_G"][center_pos(i, n)] = random_h()

        # robust
        for t in types:
            print(*a[:4], "".join(s[t]), sep="\t", file=outs[t])

    for out in outs.values():
        out.close()

    print(f"seed{seed} done")