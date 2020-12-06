file = open('input.txt', 'r')
lines = file.read().split('\n\n')

counts = []

for group in lines:
    counts.append(len(set(group.replace('\n', ''))))

print(sum(counts))
