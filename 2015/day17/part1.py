from itertools import combinations

content = open('input.txt').read()
lines = content.splitlines()

containers = [int(line) for line in lines]
target = 150

count = 0

for i in range(1, len(containers) + 1):
    for comb in list(combinations(containers, i)):
        if sum(comb) == target:
            count = count + 1

print(count)
