file = open('input.txt', 'r')
lines = file.read().splitlines()
line_length = len(lines[0])

arr = []
for line in lines:
    arr.extend(list(line))


def get_pos(x, y):
    i = (y - 1) * line_length + (x - 1) % line_length
    return arr[i]


def count_trees(right, down):
    x = 1
    y = 1
    trees = 0

    while True:
        if y > len(lines):
            break

        if get_pos(x, y) == '#':
            trees += 1

        x += right
        y += down

    return trees


slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
mul = 1

for right, down in slopes:
    mul = mul * count_trees(right, down)

print(mul)
