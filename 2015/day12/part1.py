import re

content = open('input.txt', 'r').read()
lines = content.splitlines()

total = 0

for line in lines:
    numbers = [int(m.group()) for m in re.finditer('-?\d+', line)]
    total += sum(numbers)

print(total)
