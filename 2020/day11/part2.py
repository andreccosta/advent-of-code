file = open('input.txt', 'r')
lines = file.read().splitlines()

rows = len(lines)
cols = len(lines[0])


def next_state(map):
    newMap = [[None for i in range(cols)] for j in range(rows)]
    changed = False

    for y in range(rows):
        for x in range(cols):
            if map[y][x] == ".":
                newMap[y][x] = "."
            else:
                occupied = 0
                for dr in range(-1, 2):
                    for dc in range(-1, 2):
                        if dr == dc == 0:
                            continue

                        yy = y
                        xx = x

                        while True:
                            yy += dr
                            xx += dc

                            if (not 0 <= yy < rows) or (not 0 <= xx < cols):
                                break

                            if lines[yy][xx] != ".":
                                occupied += lines[yy][xx] == "#"
                                break

                if lines[y][x] == "L" and occupied == 0:
                    changed = True
                    newMap[y][x] = "#"

                elif lines[y][x] == "#" and occupied >= 5:
                    changed = True
                    newMap[y][x] = "L"

                else:
                    newMap[y][x] = lines[y][x]

    return newMap, changed


changed = True

while changed:
    lines, changed = next_state(lines)

print(sum([line.count('#') for line in lines]))
