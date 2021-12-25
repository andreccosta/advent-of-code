require 'algorithms'
require 'set'

COSTS = {
  'A' => 1,
  'B' => 10,
  'C' => 100,
  'D' => 1000
}.freeze

HALLWAY_STOPS = [0, 1, 3, 5, 7, 9, 10].freeze
ROOM_COLS = [2, 4, 6, 8].freeze

map = {}

lines = File.readlines("input.txt", chomp: true)
lines.each.with_index do |line, row|
  line.chars.each.with_index do |c, col|
    map[[row - 1, col - 1]] = [c, false] if ('A'..'D').include?(c)
  end
end

$seen = Set.new
def search(map)
  queue = Containers::PriorityQueue.new
  queue.push [map, 0], 0

  loop do
    map, cost = queue.pop
    next unless $seen.add?(map)

    return cost if score(map) == 8

    generate_states(map, cost).each do |a, c|
      queue.push([a, c], -c)
    end
  end
end

def score(map)
  map.count do |(_, col), (type, _)|
    col.even? && ((col / 2) - 1) == type.ord - 'A'.ord
  end
end

def generate_states(map, cost)
  hallways, rooms = map.partition { |pos, _| pos[0].zero? }

  hallways.each do |pos, (type, _)|
    ROOM_COLS.each.with_index do |col, idx|
      next if type.ord - 'A'.ord != idx
      next if (1..2).any? do |row|
        map[[row, col]] && map[[row, col]].first != type
      end

      next if hallway_blocked_between? map, pos[1], col
      next if map[[1, col]]

      dest = [1, col]

      loop do
        break if map[[dest[0] + 1, col]] || dest[0] == 2

        dest[0] += 1
      end

      m = map.clone
      m.delete pos
      m[dest] = [type, true]
      return [[
        m,
        cost + COSTS[type] * ((pos[0] - dest[0]).abs + (pos[1] - dest[1]).abs)
      ]]
    end
  end

  next_states = []
  rooms.each do |pos, (type, entered_room)|
    next if entered_room
    next if pos[0] > 1 && map.keys.any? do |row, col|
      row < pos[0] && col == pos[1]
    end

    HALLWAY_STOPS.each do |hallway_idx|
      next if hallway_blocked_between?(map, pos[1], hallway_idx)

      m = map.clone
      m.delete pos
      m[[0, hallway_idx]] = [type, entered_room]
      next_states.push([
        m,
        cost + COSTS[type] * (pos[0] + (pos[1] - hallway_idx).abs)
      ])
    end
  end

  next_states
end

def hallway_blocked_between?(map, i, j)
  range = i < j ? (i + 1)..j : j..(i - 1)
  map.keys.any? { |row, col| row.zero? && range.include?(col) }
end

p search(map)
