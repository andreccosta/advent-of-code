import itertools
import math
import re

content = open('input.txt', 'r').read()
lines = content.splitlines()

ingredients = {}
pattern = r'^(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)'

for line in lines:
    ingredient, capacity, dur, flavor, texture, calories = re.match(
        pattern, line).groups()
    ingredients[ingredient] = (int(capacity), int(
        dur), int(flavor), int(texture), int(calories))

combs = itertools.combinations_with_replacement(ingredients, 100)


def score(comb):
    partials = [0, 0, 0, 0]
    cals = 0

    for i in ingredients:
        spoons = comb.count(i)
        for idx, v in enumerate(ingredients[i][:-1]):
            partials[idx] += spoons * v
        cals += spoons * ingredients[i][4]

    return math.prod([max(0, v) for v in partials]) if cals == 500 else 0


print(max(score(c) for c in combs))
