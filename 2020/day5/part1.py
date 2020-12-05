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
max_id = 0

for line in lines:
    row_codes = line[:7]
    col_codes = line[7:]

    row = int(row_codes.replace('F', '0').replace('B', '1'), 2)
    col = int(col_codes.replace('L', '0').replace('R', '1'), 2)
    max_id = max(max_id, row * 8 + col)

print(max_id)
