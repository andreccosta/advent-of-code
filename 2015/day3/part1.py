content = open('input.txt', 'r').read()
line = content.splitlines()[0]

pos = (0, 0)
gifts = {pos}

gifts = set()

dirs = {
    '^': (0, 1),
    'v': (0, -1),
    '<': (-1, 0),
    '>': (1, 0)
}


def _move(pos, dir):
    return tuple([x+y for x, y in zip(pos, dir)])


for char in line:
    pos = _move(pos, dirs[char])
    gifts.add(pos)

print(len(gifts))
