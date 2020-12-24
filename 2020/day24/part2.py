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
blacktiles = set()


def _valid(x, y):
    return (x + y) % 2 == 0


def _countneighbors(position):
    total = 0
    x, y = position

    for direction in directions.values():
        dx, dy = direction

        if (x + dx, y + dy) in blacktiles:
            total += 1

    return total


for line in lines:
    position = (0, 0)
    tokens = pattern.findall(line)

    for token in tokens:
        direction = directions[token]
        x, y = position
        dx, dy = direction
        position = (x + dx, y + dy)

    if position in blacktiles:
        blacktiles.remove(position)
    else:
        blacktiles.add(position)

for day in range(100):
    new_blacktiles = blacktiles.copy()
    whites = set()

    min_x = min(pos[0] for pos in blacktiles)
    max_x = max(pos[0] for pos in blacktiles)
    min_y = min(pos[1] for pos in blacktiles)
    max_y = max(pos[1] for pos in blacktiles)

    for x in range(min_x - 2, max_x + 3):
        for y in range(min_y - 2, max_x + 3):
            if not _valid(x, y):
                continue

            position = (x, y)

            if position in blacktiles:
                if _countneighbors(position) == 0 or _countneighbors(position) > 2:
                    new_blacktiles.remove(position)
            else:
                if _countneighbors(position) == 2:
                    new_blacktiles.add(position)

    blacktiles = new_blacktiles

print(len(blacktiles))
