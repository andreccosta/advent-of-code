file = open('input.txt', 'r')
lines = file.read().splitlines()

# acc - increases accumulator
# jmp - jumps to instruction
# nop - no operation

instructions = []

for instruction in lines:
    op, arg = instruction.split(' ', 1)
    instructions.append((op, arg))

acc = 0
visited = set()
index = 0

while index < len(instructions):
    instruction = instructions[index]
    op = instruction[0]

    if index in visited:
        break

    visited.add(index)

    if op == "acc":
        acc += int(instruction[1])
    elif op == "jmp":
        arg = int(instruction[1])
        index += int(instruction[1])
        continue

    index += 1

print(acc)
