import collections

file = open('input.txt', 'r')
cups = collections.deque(int(n) for n in list(file.read().strip()))
maximum = max(cups)
moves = 100

for _ in range(moves):
    cup = cups[0]
    cups.rotate(-1)
    label = (cup - 1)
    taken = [cups.popleft() for _ in range(3)]

    if label == 0:
        label = maximum

    while label in taken:
        label = (label - 1)

        if label == 0:
            label = maximum

    idx = cups.index(label)

    cups.rotate(-1 * idx - 1)
    cups.extend(taken)
    cups.rotate(idx + 4)

cups.rotate(-cups.index(1))
cups.popleft()

print(''.join(str(n) for n in cups))
