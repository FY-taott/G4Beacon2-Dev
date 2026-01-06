EXPECTED_BASES = 2000

# read DNA
with open('TESTNAME_std.oseq.txt', 'r') as file:
    dna_sequence = file.read().strip()

seq_length = len(dna_sequence)
if seq_length != EXPECTED_BASES:
    print(f"NOT_expected_bases")
    exit()
    
bases = ['A', 'C', 'G', 'T']

# generate all mutations
mutated_sequences = []
for i in range(seq_length):
    for base in bases:
        mutated_sequence = dna_sequence[:i] + base + dna_sequence[i+1:]
        mutated_sequences.append(mutated_sequence)
        
with open('mutateISM2.0.txt', 'w') as output_file:
    output_file.write('\n'.join(mutated_sequences))

# find same rows
with open('mutateISM2.0.txt', 'r') as output_file:
    lines = output_file.readlines()

for i, line in enumerate(lines):
    if line.strip() == dna_sequence:
        print(f"same row: {i + 1}")
