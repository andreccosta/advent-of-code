file = open('input.txt', 'r')
lines = file.read()
rows = lines.index('\n')
cols = lines.count('\n')

map = [c for c in lines if c != '\n' if c != ' ']

# . - floor
# L - empty seat
# # - occupied seat

directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1),
              (0, 1), (1, -1), (1, 0), (1, 1)]


def get_pos(map, x, y):
    return map[y * rows + x % rows]


def check_adjacent(map, x, y):
    # up, down, left, right, diagonal
    count_occupied = 0

    for direction in directions:
        try_x = x + direction[0]
        try_y = y + direction[1]

        if 0 <= try_x < rows and 0 <= try_y < cols and get_pos(map, try_x, try_y) == '#':
            count_occupied += 1

    return count_occupied


def next_state(map):
    new_map = [None] * len(map)
    changed = False

    for i, pos in enumerate(map):
        x = int(i % rows)
        y = int(i / rows)

        if pos == 'L':
            if check_adjacent(map, x, y) == 0:
                new_map[i] = '#'
                changed = True
                continue
        elif pos == '#':
            if check_adjacent(map, x, y) > 3:
                new_map[i] = 'L'
                changed = True
                continue

        new_map[i] = map[i]

    return new_map, changed


changed = True

while changed:
    map, changed = next_state(map)

print(map.count('#'))
