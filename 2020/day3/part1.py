file = open('input.txt', 'r')
lines = file.read().splitlines()
line_length = len(lines[0])

arr = []
for line in lines:
    arr.extend(list(line))

right = 3
down = 1


def get_pos(x, y):
    i = (y - 1) * line_length + (x - 1) % line_length
    return arr[i]


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

print(trees)
