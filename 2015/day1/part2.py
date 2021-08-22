file = open('input.txt', 'r')
line = file.read().splitlines()[0]

floor = 0

for idx, char in enumerate(line):
    floor += 1 if char == '(' else -1
    if floor == -1:
        print(idx + 1)
        exit(0) 
