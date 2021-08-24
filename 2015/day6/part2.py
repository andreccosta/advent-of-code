import re

content = open('input.txt', 'r').read()
lines = content.splitlines()

map = {}


def _turn(on, startx, starty, endx, endy):
    for x in range(startx, endx + 1):
        for y in range(starty, endy + 1):
            if on:
                map[(x, y)] = map.get((x, y), 0) + 1
            elif (x, y) in map.keys():
                brightness = map[(x, y)] - 1
                if brightness > 0:
                    map[(x, y)] = brightness
                else:
                    map.pop((x, y))


def _toggle(startx, starty, endx, endy):
    for x in range(startx, endx + 1):
        for y in range(starty, endy + 1):
            map[(x, y)] = map.get((x, y), 0) + 2


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

print(sum(map.values()))
