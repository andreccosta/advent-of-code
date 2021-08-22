file = open('input.txt', 'r')
line = file.read().splitlines()[0]

floor = 0

for char in line:
    floor += 1 if char == '(' else -1

print(floor)
