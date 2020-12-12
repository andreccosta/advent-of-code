file = open('input.txt', 'r')
lines = file.read().splitlines()


def compute():
    for prev_line in lines:
        for line in lines[1:]:
            if [x == y for x, y in zip(prev_line, line)].count(False) == 1:
                return ''.join([c for i, c in enumerate(prev_line) if line[i] == c])


print(compute())
