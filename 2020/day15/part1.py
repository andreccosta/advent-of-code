from collections import deque

file = open('input.txt', 'r')
start = [int(n) for n in file.read().strip().split(',')]

memory = dict()
target = 2020


def _simulate():
    for i, n in enumerate(start):
        memory[n] = deque([i, None], 2)

    for i in range(i + 1, target):
        if memory[n].count(None) > 0:
            n = 0
            memory[n].appendleft(i)
        else:
            n = memory[n][0] - memory[n][1]

            if n in memory:
                memory[n].appendleft(i)
            else:
                memory[n] = deque([i, None], 2)

    return n


print(_simulate())
