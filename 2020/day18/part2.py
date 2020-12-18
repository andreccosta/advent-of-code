import collections

file = open('input.txt', 'r')
lines = file.read().splitlines()


def _findclosing(exp, i):
    d = collections.deque()

    if exp[i] != '(':
        raise ValueError('unexpected start char')

    for k in range(i, len(exp)):
        if exp[k] == ')':
            d.popleft()

        elif exp[k] == '(':
            d.append(exp[i])

        if not d:
            return k

    return -1


def _calculate(exp):
    pos = 0
    total = 0
    op = '+'

    while pos < len(exp):
        if exp[pos].isspace():
            pass

        if exp[pos] == '(':
            start = pos
            end = _findclosing(exp, pos)

            if op == '+':
                total += _calculate(exp[start + 1: end])
            else:
                total *= _calculate(exp[start:])
                break

            pos = end

        if exp[pos] in '+*':
            op = exp[pos]

        if exp[pos].isdigit():
            if op == '+':
                total += int(exp[pos])
            else:
                total *= _calculate(exp[pos:])
                break

        pos += 1

    return total


total = 0
for expression in lines:
    total += _calculate(expression)

print(total)
