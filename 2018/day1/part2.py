file = open('input.txt', 'r')
lines = file.read().splitlines()


def compute():
    freq = 0
    seen = {0}

    while True:
        for line in lines:
            freq += int(line)

            if freq in seen:
                return freq

            seen.add(freq)


print(compute())
