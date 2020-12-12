import math

file = open('input.txt', 'r')
lines = file.read().splitlines()

directions = ['N', 'E', 'S', 'W']

"""
Starts facing east

Action N means to move waypoint north by the given value.
Action S means to move waypoint south by the given value.
Action E means to move waypoint east by the given value.
Action W means to move waypoint west by the given value.
Action L means to rotate the waypoint around the ship left (counter-clockwise) the given number of degrees.
Action R means to rotate the waypoint around the ship right (clockwise) the given number of degrees.
Action F means to move forward to the waypoint a number of times equal to the given value
"""

ship = (0, 0)
waypoint = (1, 10)


def _rotate(point, degrees):
    ns, ew = point

    if degrees == 90:
        nns = -ew
        new = ns
    elif degrees == 180:
        nns = -ns
        new = -ew
    elif degrees == 270:
        nns = ew
        new = -ns

    return (nns, new)


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


def _moveTo(position, target, count):
    return (position[0] + (target[0] * count), position[1] + (target[1] * count))


for line in lines:
    instruction = line[0]
    arg = int(line[1:])

    if instruction == 'R':
        waypoint = _rotate(waypoint, arg)
    elif instruction == 'L':
        waypoint = _rotate(waypoint, 360 - arg)
    elif instruction == 'F':
        ship = _moveTo(ship, waypoint, arg)
    else:
        waypoint = _move(waypoint, instruction, arg)

print(sum(abs(pos) for pos in ship))
