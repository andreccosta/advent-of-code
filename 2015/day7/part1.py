import re

content = open('input.txt', 'r').read()
lines = content.strip().splitlines()

machine = {}

for line in lines:
    m = (
        re.match(r'(\w+) -> (\w+)', line)
        or re.match(r'(\w+) (\w+) (\w+) -> (\w+)', line)
        or re.match(r'(\w+) (\w+) -> (\w+)', line)
    ).groups()

    machine[m[-1]] = m[:-1] if len(m) > 2 else m[0]

ops = {
    'AND': '&',
    'OR': '|',
    'LSHIFT': '<<',
    'RSHIFT': '>>',
    'NOT': '^ 65535'
}


def _parse_arg(arg):
    if re.match(r'\d+', arg):
        return int(arg)
    else:
        machine[arg] = compute(machine[arg])
        return machine[arg]


def compute(exp):
    if type(exp) == int:
        return exp
    elif type(exp) == tuple:
        if len(exp) == 1:
            return _parse_arg(exp[0])
        elif len(exp) == 2:
            op = ops[exp[0]]
            arg1 = _parse_arg(exp[1])

            return eval(f'{arg1} {op}')
        else:
            op = ops[exp[1]]
            arg1 = _parse_arg(exp[0])
            arg2 = _parse_arg(exp[2])

            return eval(f'{arg1} {op} {arg2}')
    else:
        return _parse_arg(exp)


for state in machine:
    machine[state] = compute(machine[state])

print(machine['a'])
