import math

file = open('input.txt', 'r')
sections = file.read().split('\n\n')

rules = []

header = sections[0].splitlines()
for rule in header:
    name, conditions = rule.split(':')

    c = []

    for condition in conditions.split(' or '):
        start, end = condition.strip().split('-')

        c.append((start, end))

    rules.append(c)

your_ticket = sections[1].splitlines()[1]
nearby_tickets = sections[2].splitlines()[1:]


def _isvalid(ticket, rules):
    ticket_parts = [part.strip() for part in ticket.split(',')]
    results = []

    flat_rules = [item for sublist in rules for item in sublist]

    for part in ticket_parts:
        r = []

        for (start, end) in flat_rules:
            r.append(int(start) <= int(part) <= int(end))

        results.append(any(r))

    return all(results)


def _whatrules(ticket, rules):
    ticket_parts = [part.strip() for part in ticket.split(',')]
    rules_indexes = []

    for part in ticket_parts:
        rules_index = []

        for i, r in enumerate(rules):
            for (start, end) in r:
                if int(start) <= int(part) <= int(end):
                    rules_index.append(i)

        rules_indexes.append(rules_index)

    return rules_indexes


valid_nearby_tickets = [
    ticket for ticket in nearby_tickets if _isvalid(ticket, rules)]

valid_rules_tickets = [_whatrules(ticket, rules)
                       for ticket in valid_nearby_tickets]

possible_rules = []

for valid_rules in zip(*valid_rules_tickets):
    result = None

    for valid_rule in valid_rules:
        if result is None:
            result = set(valid_rule)
        else:
            result = result.intersection(set(valid_rule))

    possible_rules.append(result)


def _solvepossibles(possible_rules):
    seen = set()

    while True:
        unique = None

        for index, rule in enumerate(possible_rules):
            if len(rule) == 1 and index not in seen:
                unique = rule
                seen.add(index)
                break

        if unique is None:
            return

        for index, rule in enumerate(possible_rules):
            if len(rule) > 1:
                possible_rules[index] = rule.difference(unique)


_solvepossibles(possible_rules)

your_ticket_parts = [part.strip() for part in your_ticket.split(',')]
values = []

unique_rules = [r.pop() for r in possible_rules]

for i in range(6):
    index = unique_rules.index(i)
    value = your_ticket_parts[index]
    values.append(int(value))

print(math.prod(values))
