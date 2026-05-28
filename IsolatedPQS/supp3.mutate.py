import sys

bed_file = sys.argv[1]
txt_file = sys.argv[2]
out_file = sys.argv[3]

window = 200

bed_lines = [x.strip().split() for x in open(bed_file) if x.strip() and not x.startswith("#")]
txt_lines = [x.strip().upper() for x in open(txt_file) if x.strip()]

out = open(out_file, "w")
report = open(out_file + ".report.txt", "w")

for i in range(len(bed_lines)):
    bed = bed_lines[i]
    seq = txt_lines[i]

    ref = bed[3].upper()
    alt = bed[4].upper()

    center = len(seq) // 2
    left = max(0, center - window)
    right = min(len(seq), center + window)

    pos = seq[left:right].find(ref)

    if pos != -1:
        pos += left
    else:
        hits = [
            j for j in range(len(seq) - len(ref) + 1)
            if seq[j:j + len(ref)] == ref
        ]
        pos = min(hits, key=lambda x: abs(x - center))

    out.write(seq[:pos] + alt + seq[pos + len(ref):] + "\n")
    report.write(f"line{i + 1}: {ref} -> {alt}, pos={pos}\n")

out.close()
report.close()