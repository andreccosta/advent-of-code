from operator import add, sub

file = open('input.txt', 'r')
blocks = file.read().split('\n\n')


def _col(tile, n):
    return ''.join(tile[r][n] for r in range(len(tile)))


def _row(tile, n):
    return tile[n]


class Tile:
    def __init__(self, s, skip=False):
        self.body = s.splitlines()

        if not skip:
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

    def variants(self):
        t = [''.join(line[j] for line in self.body)
             for j in range(len(self.body))]

        return [
            self.body,
            self.body[::-1],
            [line[::-1] for line in self.body],
            [line[::-1] for line in self.body][::-1],
            t,
            t[::-1],
            [line[::-1] for line in t],
            [line[::-1] for line in t][::-1],
        ]


tiles = []

for block in blocks:
    tiles.append(Tile(block))

board = dict()
board[(0, 0)] = tiles[0].body

while tiles:
    adds = []
    dels = []

    for pos, tile in board.items():
        for i, new in enumerate(tiles):
            for alt_body in new.variants():
                if _col(tile, len(tile) - 1) == _col(alt_body, 0):
                    adds.append((tuple(map(add, pos, (0, 1))), alt_body))
                    dels.append(i)
                    break
                if _col(tile, 0) == _col(alt_body, len(tile) - 1):
                    adds.append((tuple(map(sub, pos, (0, 1))), alt_body))
                    dels.append(i)
                    break
                if _row(tile, 0) == _row(alt_body, len(tile) - 1):
                    adds.append((tuple(map(add, pos, (-1, 0))), alt_body))
                    dels.append(i)
                    break
                if _row(tile, len(tile) - 1) == _row(alt_body, 0):
                    adds.append((tuple(map(sub, pos, (-1, 0))), alt_body))
                    dels.append(i)
                    break

    for pos, body in adds:
        board[pos] = body
    for i in reversed(sorted(set(dels))):
        del tiles[i]


minr = min(pos[0] for pos in board)
maxr = max(pos[0] for pos in board)
minc = min(pos[1] for pos in board)
maxc = max(pos[1] for pos in board)

boardstr = ''

for r in range(min(pos[0] for pos in board), max(pos[0] for pos in board) + 1):
    for i in range(len(board[(0, 0)]) - 2):
        for c in range(min(pos[1] for pos in board), max(pos[1] for pos in board) + 1):
            boardstr += board[(r, c)][1 + i][1:-1]
        boardstr += '\n'

board = Tile(boardstr, True)

monster = """                  #
#    ##    ##    ###
 #  #  #  #  #  #   """

total_hashes = sum(line.count('#') for line in boardstr)
monster_hashes = monster.count('#')


def find_monster(body, r, c):
    for ro, line in enumerate(monster.split('\n')):
        for co, ch in enumerate(line):
            if (ch == '#' and
                (r + ro >= len(body) or
                 c + co >= len(body) or
                 body[r + ro][c + co] != '#')):
                return False
    return True


for variant in board.variants():
    sightings = 0
    for r in range(len(variant)):
        for c in range(len(variant)):
            if find_monster(variant, r, c):
                sightings += 1

    if sightings > 0:
        print(total_hashes - monster_hashes * sightings)
