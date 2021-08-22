content = open('input.txt').read()
lines = content.splitlines()

total = 0


def _area(w, h, l):
    sides = [l*w, w*h, h*l]
    return 2 * sum(sides) + min(sides)


for line in lines:
    w, h, l = [int(e) for e in line.split('x')]
    total += _area(w, h, l)

print(total)
