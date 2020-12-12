file = open('input.txt', 'r')
lines = file.read().splitlines()

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

directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
ship = (0, 0)
waypoint = (10, 1)


def _rotate(point, degrees):
    px, py = point

    if degrees == 90:
        nx = -py
        ny = px
    elif degrees == 180:
        nx = -px
        ny = -py
    elif degrees == 270:
        nx = py
        ny = -px

    return (nx, ny)


def _move(position, direction, count):
    dx, dy = direction
    px, py = position

    return (px + dx * count, py + dy * count)


for line in lines:
    instruction = line[0]
    arg = int(line[1:])

    if instruction == 'R':
        waypoint = _rotate(waypoint, 360 - arg)
    elif instruction == 'L':
        waypoint = _rotate(waypoint, arg)
    elif instruction == 'F':
        ship = _move(ship, waypoint, arg)
    else:
        waypoint = _move(waypoint, directions["NESW".index(instruction)], arg)

print(sum(abs(pos) for pos in ship))
