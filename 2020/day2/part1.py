import re

file = open('input.txt', 'r')
lines = file.read().splitlines()
results = []


def validate_password(low, high, char, password):
    count = password.count(char)
    return count >= low and count <= high


for line in lines:
    matches = re.search(r"(\d+)-(\d+) ([a-z]): (\w+)", line)
    low = int(matches.group(1))
    high = int(matches.group(2))
    char = matches.group(3)
    password = matches.group(4)

    # print(f"{low} - {high} {char}: {password}")

    is_valid = validate_password(low, high, char, password)
    results.append(is_valid)

    # print(is_valid)

print(results.count(True))
