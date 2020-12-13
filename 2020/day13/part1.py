import math

file = open('input.txt', 'r')
lines = file.read().splitlines()

timestamp = int(lines[0])
ids = [int(c) for c in lines[1].split(',') if c != 'x']

next_stops = [math.ceil(timestamp / id) - (timestamp / id) for id in ids]
closest_stop = min(next_stops)
next_stop_id = ids[next_stops.index(closest_stop)]

next_stop_timestamp = math.ceil(timestamp / next_stop_id) * next_stop_id

print(next_stop_id * (next_stop_timestamp - timestamp))
