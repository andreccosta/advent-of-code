from functools import reduce
import re

file = open('input.txt', 'r')
lines = file.read().splitlines()

mask = int('0' * 36)
memory = dict()
pattern = re.compile(r"mem\[([0-9]+)\]")

for line in lines:
    op, value = line.split(' = ')

    if op == 'mask':
        mask = value
    else:
        matches = pattern.match(op)
        address = int(matches[1])

        bin_x = format(int(value), '036b')
        result = list(map(lambda b, m: b if m == 'X' else m, bin_x, mask))
        memory[address] = int(''.join(result), 2)

print(sum(memory.values()))
