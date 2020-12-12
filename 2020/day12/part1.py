file = open('input.txt', 'r')
lines = file.read().splitlines()

directions = ['N', 'E', 'S', 'W']

"""
Starts facing east

Action N means to move north by the given value.
Action S means to move south by the given value.
Action E means to move east by the given value.
Action W means to move west by the given value.
Action L means to turn left the given number of degrees.
Action R means to turn right the given number of degrees.
Action F means to move forward by the given value in the direction the ship is currently facing.
"""

direction = 'E'
position = (0, 0)


def _rotate(degrees):
    i = directions.index(direction)
    return directions[(i + int(degrees / 90)) % len(directions)]


def _move(position, direction, count):
    if direction == 'N':
        position = (position[0] + count, position[1])
    elif direction == 'S':
        position = (position[0] - count, position[1])
    elif direction == 'E':
        position = (position[0], position[1] + count)
    elif direction == 'W':
        position = (position[0], position[1] - count)

    return position


for line in lines:
    instruction = line[0]
    arg = int(line[1:])

    if instruction == 'R':
        direction = _rotate(arg)
    elif instruction == 'L':
        direction = _rotate(360 - arg)
    elif instruction == 'F':
        position = _move(position, direction, arg)
    else:
        position = _move(position, instruction, arg)

print(sum(abs(pos) for pos in position))
