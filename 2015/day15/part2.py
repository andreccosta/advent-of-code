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
    cap = dur = flavor = texture = cal = 0

    for i in ingredients:
        spoons = comb.count(i)
        info = ingredients[i]

        cap += spoons * info[0]
        dur += spoons * info[1]
        flavor += spoons * info[2]
        texture += spoons * info[3]
        cal += spoons * info[4]

    return max(0, cap) * max(0, dur) * max(0, flavor) * max(0, texture) if cal == 500 else 0


print(max(score(c) for c in combs))
