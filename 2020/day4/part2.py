import re

file = open('input.txt', 'r')
lines = file.read().split('\n\n')

required = frozenset(('byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid'))
count = 0

for passport in lines:
    fields_split = [s.strip().split(':', 1) for s in passport.split()]
    fields = {k: v for k, v in fields_split}

    if (fields.keys() >= required and
            1920 <= int(fields['byr']) <= 2002 and
            2010 <= int(fields['iyr']) <= 2020 and
            2020 <= int(fields['eyr']) <= 2030 and
            (height := re.match(r'^(\d+)(cm|in)$', fields['hgt'])) and
            (height[2] == 'cm' and 150 <= int(height[1]) <= 193 or
             height[2] == 'in' and 59 <= int(height[1]) <= 76) and
            re.match('^#[a-f0-9]{6}$', fields['hcl']) and
            fields['ecl'] in set('amb blu brn gry grn hzl oth'.split()) and
            re.match('^[0-9]{9}$', fields['pid'])):
        count += 1

print(count)
