from collections import deque

file = open('input.txt', 'r')
p1s, p2s = file.read().split('\n\n')

p1 = deque([int(c) for c in p1s.splitlines()[1:]])
p2 = deque([int(c) for c in p2s.splitlines()[1:]])


def _game(p1, p2):
    while True:
        if p1 and not p2:
            return 1
        if p2 and not p1:
            return 2

        c1, c2 = p1.popleft(), p2.popleft()

        winner = 1 if c1 > c2 else 2

        if winner == 1:
            p1.extend([c1, c2])
        else:
            p2.extend([c2, c1])


_game(p1, p2)

wq = p1 if p1 else p2
print(sum((len(wq) - i) * v for i, v in enumerate(wq)))
