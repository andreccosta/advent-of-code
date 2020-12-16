from collections import defaultdict
import itertools

file = open('input.txt', 'r')
lines = file.read().splitlines()

space = defaultdict(bool)

for y, line in enumerate(lines):
    for x, c in enumerate(line):
        if c == '#':
            space[x, y, 0, 0] = True

"""
# - active
. - inactive

boot up 6 cycles

"""

cycles = 6
directions = [x for x in itertools.product(
    {-1, 0, 1}, repeat=4) if x != (0, 0, 0, 0)]


def _simulate(space):
    low = [min(p[i] for p in space) - 1 for i in range(4)]
    high = [max(p[i] for p in space) + 1 for i in range(4)]

    newspace = defaultdict(bool)

    for x in range(low[0], high[0] + 1):
        for y in range(low[1], high[1] + 1):
            for z in range(low[2], high[2] + 1):
                for w in range(low[3], high[3] + 1):
                    neighbors = sum(space[x+dx, y+dy, z+dz, w+dw]
                                    for dx, dy, dz, dw in directions)
                    if space[x, y, z, w]:
                        newspace[x, y, z, w] = neighbors in [2, 3]
                    else:
                        newspace[x, y, z, w] = neighbors == 3

    return newspace


for _ in range(cycles):
    space = _simulate(space)

print(sum(space.values()))
