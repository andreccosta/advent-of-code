import re

content = open('input.txt', 'r').read()
lines = content.splitlines()

pattern = r'(\w+) can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+) seconds'
reindeers = {}

for line in lines:
    reindeer, speed, fly_time, rest_time = re.match(pattern, line).groups()

    reindeers[reindeer] = {'speed': int(speed),
                           'fly_time': int(fly_time),
                           'rest_time': int(rest_time)}


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


best = 0
seconds = 2503

for r in reindeers:
    distance = calculate(r, seconds)
    if distance > best:
        best = distance

print(best)
