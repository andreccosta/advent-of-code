import re

content = open('input.txt', 'r').read()
lines = content.splitlines()

pattern = r'(\w+) can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+) seconds'
reindeers = {}

for line in lines:
    reindeer, speed, fly_time, rest_time = re.match(pattern, line).groups()

    reindeers[reindeer] = {'speed': int(speed),
                           'fly_time': int(fly_time),
                           'rest_time': int(rest_time),
                           'score': 0}


def calculate(reindeer, seconds):
    r = reindeers[reindeer]
    total_time = r['fly_time'] + r['rest_time']

    parts = seconds // total_time
    remainder = seconds % total_time

    distance = r['speed'] * r['fly_time'] * parts

    if remainder > r['fly_time']:
        distance += r['speed'] * r['fly_time']
    else:
        distance += r['speed'] * remainder

    return distance


seconds = 2503
best_distance = 0
best_reindeers = set()

for second in range(1, seconds):
    best_distance = 0

    for r in reindeers:
        distance = calculate(r, second)

        if distance > best_distance:
            best_distance = distance
            best_reindeers = {r}
        elif distance == best_distance:
            best_reindeers.add(r)

    for r in best_reindeers:
        reindeers[r]['score'] += 1

    best_reindeers.clear()

print(max(reindeers[x]['score'] for x in reindeers))
