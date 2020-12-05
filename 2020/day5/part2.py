file = open('input.txt', 'r')
lines = file.read().splitlines()

# F means "front"
# B means "back"
# L means "left"
# R means "right"

# 128 rows - 0 to 127
# first 7 letters - front or back
# first letter - first half - 0 to 63 or 64 to 127

# 8 columns
# last 3 letters - right or left

# unique id
# id = row * 8 + col

ids = []

for line in lines:
    row_codes = line[:7]
    col_codes = line[7:]

    row = int(row_codes.replace('F', '0').replace('B', '1'), 2)
    col = int(col_codes.replace('L', '0').replace('R', '1'), 2)
    id = row * 8 + col

    ids.append(id)

ids.sort()
previous_id = -1

for id in ids:
    if previous_id > 0 and id - previous_id != 1:
        print(f'gap found {previous_id} {id}')

    previous_id = id
