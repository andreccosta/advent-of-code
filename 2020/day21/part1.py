file = open('input.txt', 'r')
lines = file.read().splitlines()

possibles = {}
all_ingredients = []


def _solve(d):
    seen = set()

    while True:
        key, unique = next(((k, v)
                            for k, v in d.items() if k not in seen and len(v) == 1), (None, None))

        if unique is None:
            return
        else:
            seen.add(key)

        for k, v in d.items():
            if len(v) > 1:
                d[k] = list(set(v).difference(unique))


for line in lines:
    ingredients, allergens = line.split(' (contains ')
    ingredients = ingredients.strip().split()
    allergens = allergens.replace(')', '').strip().split(', ')

    all_ingredients.append(ingredients)

    for allergen in allergens:
        if allergen in possibles:
            possibles[allergen] = list(
                set(possibles[allergen]) & set(ingredients))
        else:
            possibles[allergen] = set(ingredients)

_solve(possibles)

known_ingredients = [
    y for x in possibles.values() for y in x]

total = 0
for ingredients in all_ingredients:
    for i in ingredients:
        if i not in known_ingredients:
            total += 1
print(total)
