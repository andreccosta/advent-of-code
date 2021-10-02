import re

content = open('input.txt').read()
lines = content.splitlines()

pattern = r'^Sue (\d+): (.*)'

aunts = {}

for line in lines:
    id, rest = re.match(pattern, line).groups()
    parts = rest.split(', ')

    compounds = {}

    for part in parts:
        compound, quantity = part.split(': ')
        compounds[compound] = quantity

    aunts[id] = compounds

found = '''children: 3
cats: 7
samoyeds: 2
pomeranians: 3
akitas: 0
vizslas: 0
goldfish: 5
trees: 3
cars: 2
perfumes: 1'''

found_compounds = {}

for line in found.splitlines():
    compound, quantity = line.split(': ')
    found_compounds[compound] = quantity


greater_than = ['cats', 'trees']
fewer_than = ['pomeranians', 'goldfish']

for aunt in aunts:
    skip = False
    aunt_compounds = aunts[aunt]

    for c in aunt_compounds:
        if c in found_compounds:
            if c in greater_than:
                if found_compounds[c] > aunt_compounds[c]:
                    skip = True
            elif c in fewer_than:
                if found_compounds[c] < aunt_compounds[c]:
                    skip = True
            else:
                if found_compounds[c] != aunt_compounds[c]:
                    skip = True

    if skip:
        continue

    print(aunt)
    exit()
