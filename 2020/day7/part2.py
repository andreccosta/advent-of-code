import collections
import re

file = open('input.txt', 'r')
lines = file.read().splitlines()

tree = collections.defaultdict(list)
pattern = re.compile(r"(^\w+ \w+) bags contain (?:no other bags.|((\d \w+ \w+ (?:bags|bag)(?:\.|, ))*))$")
contents_pattern = re.compile(r"(\d) (\w+ \w+)")

for line in lines:
    matches = pattern.match(line)
    color = matches[1]

    if matches[2] == None:
        contents = []
    else:
        contents = contents_pattern.findall(matches[2])

    for k in contents:
        tree[color] = contents

def count_bags(color):
    subcolors = tree[color]

    count = 1
    
    for subcolor in subcolors:
        count += int(subcolor[0]) * count_bags(subcolor[1])
    
    return count

print(count_bags('shiny gold') - 1)
