import itertools

file = open('input.txt', 'r')
lines = [int(x) for x in file.read().splitlines()]

# find a contiguous set of at least two numbers that sum
# sum smallest and largest

weakness = 105950735

for i, x in enumerate(lines):
    for w, y in enumerate(lines[i + 1:]):
        if sum(lines[i:w]) == weakness:
            print(min(lines[i:w]) + max(lines[i:w]))
            quit()
