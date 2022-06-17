file = open('input.txt', 'r')
lines = file.read().splitlines()

freq = 0

for line in lines:
    freq += int(line)

print(freq)
