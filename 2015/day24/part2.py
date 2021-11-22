from itertools import combinations
from math import prod

def main():
    with open('input.txt') as f:
        content = f.read()
        weights = [int(l) for l in content.splitlines()]

        total_weight = sum(weights)
        target_weight = total_weight / 4

        shortest_combs = shortest_combination_sum(weights, target_weight)
        print(min([prod(s) for s in shortest_combs]))

def shortest_combination_sum(sequence, target):
    results = []
    shortest_length = None

    for i in range(1, len(sequence)):
        for c in combinations(sequence, i):
            if sum(c) == target:
                if shortest_length is None:
                    shortest_length = i

                if i > shortest_length:
                    return results

                results.append(c)

    return results

if __name__ == "__main__":
    main()
