file = open('input.txt', 'r')
blocks = file.read().split('\n\n')


def _col(tile, n):
    return ''.join(tile[r][n] for r in range(len(tile)))


def _row(tile, n):
    return tile[n]


class Tile:
    def __init__(self, s):
        self.id, self.content = s.split(':\n')

        self.body = [l for l in self.content.splitlines()]

        self.edges = [
            _col(self.body, 0),
            _col(self.body, len(self.body) - 1),
            _row(self.body, 0),
            _row(self.body, len(self.body) - 1)
        ]

        self.edges += [s[::-1] for s in self.edges]

        self.id = int(self.id.replace('Tile ', ''))


tiles = []

for block in blocks:
    tiles.append(Tile(block))


matches = {}

for t in tiles:
    matches[t.id] = set()

    for o in tiles:
        if t == o:
            continue

        for e in t.edges:
            if e in o.edges:
                matches[t.id].add(o.id)
                break

total = 1
for m in matches:
    if len(matches[m]) == 2:
        total *= m

print(total)
