def matrix_to_csv(matrix_file, csv_file):
    with open(matrix_file, 'r') as infile, open(csv_file, 'w') as outfile:
        for _ in range(3):
            infile.readline()
        for line in infile:
            line = line.replace("nan", "0.0").replace("\t", ",")
            outfile.write(line)

if __name__ == "__main__":
    matrix_file = "K562_ug4_minus_normalized_ATAC_K562_1000bp.matrix"
    csv_file = "K562_ug4_minus_normalized_ATAC_K562_1000bp.csv"
    matrix_to_csv(matrix_file, csv_file)

    matrix_file = "K562_ug4_plus_normalized_ATAC_K562_1000bp.matrix"
    csv_file = "K562_ug4_plus_normalized_ATAC_K562_1000bp.csv"
    matrix_to_csv(matrix_file, csv_file)

    matrix_file = "K562_vg4_minus_normalized_ATAC_K562_1000bp.matrix"
    csv_file = "K562_vg4_minus_normalized_ATAC_K562_1000bp.csv"
    matrix_to_csv(matrix_file, csv_file)

    matrix_file = "K562_vg4_plus_normalized_ATAC_K562_1000bp.matrix"
    csv_file = "K562_vg4_plus_normalized_ATAC_K562_1000bp.csv"
    matrix_to_csv(matrix_file, csv_file)
