file = open('input.txt', 'r')
header, your_ticket, nearby_tickets = file.read().split('\n\n')


def _parserules(header):
    rules = []

    for rule in header:
        name, conditions = rule.split(':')

        c = []

        for condition in conditions.split(' or '):
            start, end = condition.strip().split('-')

            c.append((start, end))

        rules.append(c)

    return rules


def _getinvalid(ticket, rules):
    ticket_parts = [part.strip() for part in ticket.split(',')]
    results = []

    flat_rules = [item for sublist in rules for item in sublist]

    for part in ticket_parts:
        r = []

        for (start, end) in flat_rules:
            r.append(int(start) <= int(part) <= int(end))

        if not any(r):
            results.append(int(part))

    return results


header = header.splitlines()
rules = _parserules(header)

nearby_tickets = nearby_tickets.splitlines()[1:]

invalid_parts = []

for ticket in nearby_tickets:
    for p in _getinvalid(ticket, rules):
        invalid_parts.append(p)

print(sum(invalid_parts))
