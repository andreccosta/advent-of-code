from itertools import combinations

content = open('input.txt', 'r').read()
lines = content.splitlines()


def _one_between(line):
    for char in set(line):
        for (a, b) in combinations([i for i, x in enumerate(line) if x == char], 2):
            if abs(b - a) == 2:
                return True
    return False


def _has_pair(line):
    for pair in [a + b for (a, b) in zip(line, line[1:])]:
        if line.count(pair) >= 2:
            return True
    return False


def _is_valid(line):
    return _one_between(line) and _has_pair(line)


print(sum(1 if _is_valid(line) else 0 for line in lines))
