from collections import defaultdict
import re

content = open('input.txt').read()
formulas, molecule = content.strip().split('\n\n')

transitions = defaultdict(set)

for formula in formulas.splitlines():
    src, dst = formula.split(' => ')
    transitions[src].add(dst)

new_molecules = set()

for src in transitions:
    for dst in transitions[src]:
        for match in re.finditer(src, molecule):
            new_molecules.add(
                molecule[:match.start()] + dst + molecule[match.end():])


print(len(new_molecules))
