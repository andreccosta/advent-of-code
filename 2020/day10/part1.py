import math

file = open('input.txt', 'r')
adapters = [int(x) for x in file.read().splitlines()]

device_adapter = max(adapters) + 3
adapters.append(device_adapter)

joltage = 0
seen = []
differences = []

while len(seen) < len(adapters):
    adapter = min(adapter for adapter in adapters if adapter not in seen and
                  joltage <= adapter <= joltage + 3)
    differences.append(adapter - joltage)
    joltage = adapter
    seen.append(adapter)

diffcount = [differences.count(x) for x in set(differences)]
print(math.prod(diffcount))
