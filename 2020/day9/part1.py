import itertools

file = open('input.txt', 'r')
lines = [int(x) for x in file.read().splitlines()]

# preamble - 25 numbers
# after - each number received should be sum of any two of the 25 immediately previous

preamble = 25


def check_comb(list, target):
    for j in itertools.combinations(list, 2):
        if sum(j) == target:
            return True
    return False


for i, value in enumerate(lines[preamble:]):
    if not check_comb(lines[i:i + preamble], value):
        print(value)
        quit()
