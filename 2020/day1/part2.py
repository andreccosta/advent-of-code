dict = {}
file = open('input.txt', 'r')
lines = file.read().splitlines()
lines = list(map(int, lines))

for index, line in enumerate(lines):
    base_diff = 2020 - line
    for key, value in enumerate(dict):
        diff = base_diff - value

        if diff in lines:
            print("{} * {} * {}".format(line, value, diff))
            print("{}".format(line * value * diff))
            exit()

    dict[line] = line
