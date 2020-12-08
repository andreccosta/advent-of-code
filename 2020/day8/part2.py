file = open('input.txt', 'r')
lines = file.read().splitlines()

# acc - increases accumulator
# jmp - jumps to instruction
# nop - no operation

instructions = []

for instruction in lines:
    op, arg = instruction.split(' ', 1)
    instructions.append((op, arg))


def run(instructions):
    visited = set()
    index = 0
    acc = 0

    while index < len(instructions):
        instruction = instructions[index]
        op = instruction[0]

        if index in visited:
            raise RuntimeError('loop')

        visited.add(index)

        if op == "acc":
            acc += int(instruction[1])
        elif op == "jmp":
            index += int(instruction[1])
            continue

        index += 1

    return acc


for i, (op, arg) in enumerate(instructions):
    if op == 'nop':
        new = instructions[:]
        new[i] = ('jmp', arg)

        try:
            print(run(new))
        except RuntimeError:
            pass
    elif op == 'jmp':
        new = instructions[:]
        new[i] = ('nop', arg)

        try:
            print(run(new))
        except RuntimeError:
            pass
