from functools import reduce
import itertools
import re

file = open('input.txt', 'r')
lines = file.read().splitlines()

mask = int('0' * 36)
memory = dict()
pattern = re.compile(r"mem\[([0-9]+)\]")


def _replace(possiblities, mask):
    for possible in possiblities:
        index = 0
        x = list(mask)

        for i, s in enumerate(mask):
            if s == 'X':
                x[i] = str(possible[index])
                index += 1

        yield ''.join(x)


for line in lines:
    op, value = line.split(' = ')

    if op == 'mask':
        mask = value
    else:
        matches = pattern.match(op)
        address = format(int(matches[1]), '036b')

        masked_address = list(
            map(lambda a, m: a if m == '0' else m, address, mask))

        possible_values = list(itertools.product(
            range(2), repeat=masked_address.count('X')))

        for address_binary in _replace(possible_values, masked_address):
            address = int(address_binary, 2)
            memory[address] = int(value)

print(sum(memory.values()))
