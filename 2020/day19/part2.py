import re

file = open('input.txt', 'r')
rules, messages = file.read().split('\n\n')

lookup = {}

for rule in rules.splitlines():
    n, parts = rule.split(':')
    lookup[int(n)] = parts.strip().strip('""')


lookup[8] = '42 | 42 8'
lookup[11] = '42 31 | 42 11 31'


def _evalr(idx, lookup):
    rule = lookup[idx]
    parts = rule.split()

    exp = ''
    loop = False
    closed = False
    needs_ending_loop = False

    if len(rule) > 1:
        exp = '('

        if idx != 8 and idx != 11:
            exp += '?:'

    for c in parts:
        if loop and closed:
            exp += '('
            closed = False
            needs_ending_loop = True

        if c.isspace():
            continue

        if c.isdigit():
            if int(c) == idx:
                loop = True
                closed = True
                exp += ')+'
            else:
                exp += _evalr(int(c), lookup)
        else:
            exp += c.strip()

    if len(rule) > 1 and not closed:
        exp += ')'

    if needs_ending_loop:
        exp += '+'

    return exp


gexp = _evalr(0, lookup)
rexp = re.compile(gexp)

gexp31 = _evalr(31, lookup)
rexp31 = re.compile(gexp31)
gexp42 = _evalr(42, lookup)
rexp42 = re.compile(gexp42)


total = 0
for message in messages.splitlines():
    if rexp.fullmatch(message):
        pos = 0

        count_42 = 0
        while match := rexp42.match(message, pos):
            count_42 += 1
            pos = match.end()

        count_31 = 0
        while match := rexp31.match(message, pos):
            count_31 += 1
            pos = match.end()

        if count_31 > 0 and count_31 < count_42 and pos == len(message):
            total += 1

print(total)
