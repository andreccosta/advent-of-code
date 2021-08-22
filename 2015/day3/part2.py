content = open('input.txt', 'r').read()
line = content.splitlines()[0]

pos = [(0, 0), (0, 0)]
gifts = {(0, 0)}

dirs = {
    '^': (0, 1),
    'v': (0, -1),
    '<': (-1, 0),
    '>': (1, 0)
}


def _move(pos, dir):
    return tuple([x+y for x, y in zip(pos, dir)])


i = 0
for char in line:
    pos[i] = _move(pos[i], dirs[char])
    gifts.add(pos[i])

    i = 1 - i

print(len(gifts))
