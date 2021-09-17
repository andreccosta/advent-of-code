from collections import defaultdict
from itertools import permutations
import re

content = open('input.txt', 'r').read()
lines = content.splitlines()

pattern = r'(\w+) would (\w+) (\d+) happiness units by sitting next to (\w+)'

participants = set()
changes = defaultdict(lambda: 0)
best = 0

for line in lines:
    matches = re.match(pattern, line)
    participant, op, units, neighbor = matches.groups()

    participants.add(participant)
    changes[participant+neighbor] = int(units) if op == 'gain' else -int(units)

for perm in permutations(participants):
    total = sum(changes[a+b] + changes[b+a]
                for a, b, in zip(perm, perm[-1:]+perm[:-1]))
    if total > best:
        best = total

print(best)
