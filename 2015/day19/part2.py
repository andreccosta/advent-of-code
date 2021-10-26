import re
from queue import PriorityQueue

content = open('input.txt').read()
formulas, molecule = content.strip().split('\n\n')

transitions = dict()

for formula in formulas.splitlines():
    src, dst = formula.split(' => ')
    transitions[dst] = src

def step(initial):
    for dst in transitions:
        src = transitions[dst]
        for match in re.finditer(dst, initial):
            yield initial[:match.start()] + src + initial[match.end():]

q = PriorityQueue()
q.put((len(molecule), 0, molecule))

while True:
    length, steps, current = q.get()

    if current == 'e':
        break

    for variant in step(current):
        q.put((len(variant), steps + 1, variant))

print(steps)
