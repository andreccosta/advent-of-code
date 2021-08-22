content = open('input.txt').read()
lines = content.splitlines()

total = 0


def _perim(w, h, l):
    sides = [2*(l+w), 2*(w+h), 2*(h+l)]
    return min(sides)


def _volume(w, h, l):
    return w * h * l


for line in lines:
    w, h, l = [int(e) for e in line.split('x')]
    total += _perim(w, h, l) + _volume(w, h, l)

print(total)
