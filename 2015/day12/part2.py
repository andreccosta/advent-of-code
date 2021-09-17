import json
from typing import Iterable

content = open('input.txt', 'r').read()
data = json.loads(content)


def parse(data):
    total = 0

    if isinstance(data, int):
        return data
    elif isinstance(data, str):
        return 0
    elif isinstance(data, Iterable):
        if isinstance(data, dict):
            if "red" in data.values():
                return 0

        for x in data:
            if isinstance(data, dict):
                total += parse(data[x])
            else:
                total += parse(x)

    return total


total = parse(data)
print(total)
