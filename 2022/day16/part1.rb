require 'set'

lines = File.readlines("input.txt", chomp: true)

input = lines.flat_map do |line|
  line.scan(/Valve (..) has flow rate=(\d+); tunnels? leads? to valves? (.*)/)
    .map { [_1, _2.to_i, _3.split(", ")] }
end

def search(map, start, finish)
  queue = [[start, 0]]
  visited = Set.new

  while queue.any?
    node, steps = queue.shift

    break steps if node == finish

    map[node].each do |child|
      queue << [child, steps + 1] if visited.add?(child)
    end
  end
end

map = {}
flows = {}

input.each do |(name, flow, tunnels)|
  map[name] = tunnels
  flows[name] = flow
end

distance = {}

map.keys.combination(2) do |a, b|
  dist = search(map, a, b)
  distance[a + b] = dist
  distance[b + a] = dist
end

useful_valves = flows.keys.select { |k| flows[k] > 0 }.to_set

best_score = 0
queue = [["AA", useful_valves, 30, 0]]

until queue.empty?
  start, valves, time, score = queue.shift
  best_score = score if score > best_score

  valves.each do |valve|
    dist = distance[start + valve]

    if dist < time - 1
      remaining_time = time - dist - 1
      new_score = score + flows[valve] * remaining_time

      queue << [valve, valves.dup.delete(valve), remaining_time, new_score]
    end
  end
end

p best_score
