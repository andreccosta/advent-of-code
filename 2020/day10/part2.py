file = open('input.txt', 'r')
adapters = [int(x) for x in file.read().splitlines()]

device_adapter = max(adapters) + 3
possible = [max(adapters) % 3 == i for i in range(3)]

for x in reversed(range(1, device_adapter)):
    if x in adapters:
        possible[x % 3] = sum(possible)
    else:
        possible[x % 3] = 0

print(sum(possible))
