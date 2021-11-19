# hlf r - set r to half
# tpl r - set r to triple
# inc r - inc r by 1
# jmp offset - jump instructions
# jie r, offset - jump if r is even
# jio r, offset - jump if r is one

def hlf(reg, arg):
    reg[arg] = round(reg[arg] / 2)
    return reg


def tpl(reg, arg):
    reg[arg] *= 3
    return reg


def inc(reg, arg):
    reg[arg] += 1
    return reg


def jmp(i, arg):
    i += (arg - 1)
    return i


def jie(reg, arg):
    return reg[arg] % 2 == 0


def jio(reg, arg):
    return reg[arg] == 1


def main():
    i = 0
    instructions = []
    reg = {"a": 1, "b": 0}

    with open('input.txt') as f:
        content = f.read()
        lines = content.splitlines()

        for line in lines:
            op, arg, *parts = line.replace(',', '').split()
            offset = int(parts[0]) if parts else None
            instructions.append((op, arg, offset))

        while i < len(instructions):
            op, arg, offset = instructions[i]

            switch = {
                'hlf': hlf,
                'tpl': tpl,
                'inc': inc,
                'jmp': jmp,
                'jie': jie,
                'jio': jio
            }

            func = switch.get(op)

            if op in ['hlf', 'tpl', 'inc']:
                reg = func(reg, arg)
            elif op == 'jmp':
                i = func(i, int(arg))
            else:
                if func(reg, arg):
                    i = jmp(i, offset)

            i += 1

    print(reg["b"])

if __name__ == "__main__":
    main()
