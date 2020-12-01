dict = {}
file = open('input.txt', 'r')
lines = file.read().splitlines()
lines = list(map(int, lines))

for index, line in enumerate(lines):
    diff = 2020 - line

    if diff in lines:
        print("{} * {}".format(line, diff))
        print("{}".format(line * diff))
        exit()

    dict[line] = line
