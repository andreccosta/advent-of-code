import re

content = open('input.txt', 'r').read()
lines = content.splitlines()

map = set()


def _turn(on, startx, starty, endx, endy):
    for x in range(startx, endx + 1):
        for y in range(starty, endy + 1):
            if on:
                map.add((x, y))
            elif (x, y) in map:
                map.remove((x, y))


def _toggle(startx, starty, endx, endy):
    for x in range(startx, endx + 1):
        for y in range(starty, endy + 1):
            if (x, y) in map:
                map.remove((x, y))
            else:
                map.add((x, y))


for line in lines:
    matches = re.match(
        r'^(toggle|turn (?:on|off)) (\d+),(\d+) through (\d+),(\d+)$', line)
    if matches:
        action, startx, starty, endx, endy = [
            int(x) if idx > 0 else x for idx, x in enumerate(matches.groups())]

        if action.startswith('turn'):
            _turn('on' in action, startx, starty, endx, endy)
        else:
            _toggle(startx, starty, endx, endy)

print(len(map))
