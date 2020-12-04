file = open('input.txt', 'r')
lines = file.read().split('\n\n')

required = frozenset(('byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid'))

count = 0

for passport in lines:
    fields_split = [s.strip().split(':') for s in passport.split()]
    fields = {k: v for k, v in fields_split}

    if fields.keys() >= required:
        count += 1

print(count)
