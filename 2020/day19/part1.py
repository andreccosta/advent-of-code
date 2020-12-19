import re

file = open('input.txt', 'r')
rules, messages = file.read().split('\n\n')

lookup = {}

for rule in rules.splitlines():
    id, parts = rule.split(':')
    lookup[int(id)] = parts.strip().strip('""')


def _evalr(idx, lookup):
    rule = lookup[idx]
    parts = rule.split()

    exp = ''

    if len(rule) > 1:
        exp = r'(?:'

    for c in parts:
        if c.isspace():
            continue

        if c.isdigit():
            exp += _evalr(int(c), lookup)
        else:
            exp += c.strip()

    if len(rule) > 1:
        exp += ')'

    return exp


rexp = re.compile(_evalr(0, lookup))

total = 0
for message in messages.splitlines():
    if rexp.fullmatch(message):
        total += 1

print(total)
