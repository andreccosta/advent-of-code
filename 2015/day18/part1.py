content = open('input.txt').read()
lines = content.splitlines()

mods = [(-1, -1), (0, -1), (1, -1), (-1, 0), (1, 0), (-1, 1), (0, 1), (1, 1)]
state = [list(line) for line in lines]
state_len = len(state)
steps = 100


def step():
    curr_state = [row[:] for row in state]

    for row in range(0, state_len):
        for col in range(0, state_len):
            state[row][col] = next_state(curr_state, (col, row))


def valid_position(x, y):
    return x >= 0 and y >= 0 and x < state_len and y < state_len


def count_neighbors_on(curr_state, pos):
    count = 0
    neighbors_pos = [[sum(x) for x in zip(pos, mod)] for mod in mods]

    for neighbor_pos in neighbors_pos:
        x, y = neighbor_pos

        if not valid_position(x, y):
            continue

        if curr_state[y][x] == '#':
            count += 1

    return count


def next_state(curr_state, pos):
    x, y = pos
    is_on = curr_state[y][x] == '#'
    count = count_neighbors_on(curr_state, pos)

    if is_on and count not in [2, 3]:
        return '.'
    if not is_on and count == 3:
        return '#'

    return curr_state[y][x]


for _ in range(steps):
    step()

print(sum([row.count('#') for row in state]))
