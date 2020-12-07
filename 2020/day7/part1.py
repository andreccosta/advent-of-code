import collections
import re

file = open('input.txt', 'r')
lines = file.read().splitlines()

parents = collections.defaultdict(list)
pattern = re.compile(r"(^\w+ \w+) bags contain (?:no other bags.|((\d \w+ \w+ (?:bags|bag)(?:\.|, ))*))$")
contents_pattern = re.compile(r"\d (\w+ \w+)")

for line in lines:
    matches = pattern.match(line)
    color = matches[1]

    if matches[2] == None:
        contents = []
    else:
        contents = contents_pattern.findall(matches[2])

    for k in contents:
        parents[k].append(color)

unique_parents = set()

def check_parents(color):
    p = parents[color]

    for b in p:
        unique_parents.add(b)
        check_parents(b)

check_parents('shiny gold')

print(len(unique_parents))
