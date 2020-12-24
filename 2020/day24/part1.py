import re

file = open('input.txt', 'r')
lines = file.read().splitlines()

directions = {
    'e': (2, 0),
    'se': (1, -1),
    'sw': (-1, -1),
    'w': (-2, 0),
    'nw': (-1, 1),
    'ne': (1, 1)
}

pattern = re.compile('e|se|sw|w|nw|ne')
seen = set()

for line in lines:
    position = (0, 0)
    tokens = pattern.findall(line)

    for token in tokens:
        direction = directions[token]
        x, y = position
        dx, dy = direction
        position = (x + dx, y + dy)

    if position in seen:
        seen.remove(position)
    else:
        seen.add(position)

print(len(seen))
