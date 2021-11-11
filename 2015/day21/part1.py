from itertools import product, combinations
from typing import Iterable

class Player:
    def __init__(self, name, hit_points, damage, armor) -> None:
        self.name = name
        self.hit_points = hit_points
        self.damage = damage
        self.armor = armor

class Item:
    def __init__(self, name, cost, damage, armor) -> None:
        self.name = name
        self.cost = cost
        self.damage = damage
        self.armor = armor

# weapon - 1
weapons = [
    Item("Dagger", 8, 4, 0),
    Item("Shortsword", 10, 5, 0),
    Item("Warhammer", 25, 6, 0),
    Item("Longsword", 40 ,7, 0),
    Item("Greataxe", 74, 8, 0)
]

# armor - 0-1
armor = [
    Item("Leather", 13, 0, 1),
    Item("Chainmail", 31, 0, 2),
    Item("Splintmail", 53, 0, 3),
    Item("Chainmail", 75, 0, 4),
    Item("Chainmail", 102, 0, 5)
]

# rings - 0-2
rings = [
    Item("Damage +1", 25, 1, 0),
    Item("Damage +2", 50, 2, 0),
    Item("Damage +3", 100, 3, 0),
    Item("Defense +1", 20, 0, 1),
    Item("Defense +2", 40, 0, 2),
    Item("Defense +3", 80, 0, 3),
]

def calculate_cost(items):
    cost = 0

    for i in [i for i in items if i]:
        if isinstance(i, Iterable):
            for j in i:
                cost += j.cost
        else:
            cost += i.cost

    return cost

def all_buy_options():
    all_combs = list(product(
        [*weapons],
        [None, *armor],
        [None, *rings, *combinations(rings, 2)]
    ))
    all_combs.sort(key=calculate_cost)

    return all_combs

def buy(player, items):
    for i in items:
        if i is None:
            continue

        if isinstance(i, Iterable):
            for j in i:
                player.damage += j.damage
                player.armor += j.armor
        else:
            player.damage += i.damage
            player.armor += i.armor

def game():
    buy_options = all_buy_options()

    for buy_option in buy_options:
        boss = Player("Boss", 103, 9, 2)
        player = Player("Player", 100, 0, 0)

        buy(player, buy_option)
        winner = play(player, boss)

        if winner.name == "Player":
            print(calculate_cost(buy_option))
            return

def turn(attacker, defendant):
    defendant.hit_points -= attacker.damage - defendant.armor

def play(attacker, defendant):
    while attacker.hit_points > 0 and defendant.hit_points > 0:
        turn(attacker, defendant)

        tmp = attacker
        attacker = defendant
        defendant = tmp

    return defendant if attacker.hit_points <= 0 else attacker


game()
