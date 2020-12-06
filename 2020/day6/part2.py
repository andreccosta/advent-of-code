file = open('input.txt', 'r')
lines = file.read().split('\n\n')

counts = []

for group in lines:
    common = None

    for choices in group.splitlines():
        if common is None:
            common = set(choices)
        else:
            common = common & set(choices)

    counts.append(len(common))

print(sum(counts))
