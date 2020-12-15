from collections import deque

file = open('input.txt', 'r')
start = [int(n) for n in file.read().strip().split(',')]

memory = dict()
target = 30000000


def _simulate():
    for i, n in enumerate(start):
        if i < len(start) - 1:
            memory[n] = i

    for i in range(i + 1, target):

        if n in memory:
            prev = memory[n]
            diff = (i - 1) - prev
            memory[n] = i - 1
            n = diff
        else:
            memory[n] = i - 1
            n = 0

    return n


print(_simulate())
