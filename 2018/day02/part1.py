file = open('input.txt', 'r')
lines = file.read().splitlines()


def compute():
    two = 0
    three = 0

    for line in lines:
        counts = [line.count(char) for char in set(line)]

        if 2 in counts:
            two += 1
        if 3 in counts:
            three += 1

    return two * three


print(compute())
