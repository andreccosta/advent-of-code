import collections
import itertools
import re

content = open('input.txt', 'r').read()
lines = content.strip().splitlines()

map = collections.defaultdict(
    lambda: collections.defaultdict(
        lambda: float("inf")
    )
)

for line in lines:
    matches = re.match(r'(\w+) to (\w+) = (\d+)', line)
    origin, destination, distance = matches.groups()
    distance = int(distance)

    map[origin][destination] = distance
    map[destination][origin] = distance

length = max(
    sum(map[origin][destination]
        for origin, destination in zip(path, path[1:]))
    for path in itertools.permutations(map.keys())
)

print(length)
