require "set"

moves = File
  .readlines("input.txt", chomp: true)
  .first

map = {}

shapes = [
  [[0, 0], [1, 0], [2, 0], [3, 0]],
  [[1, 2], [0, 1], [1, 1], [2, 1], [1, 0]],
  [[2, 2], [2, 1], [0, 0], [1, 0], [2, 0]],
  [[0, 3], [0, 2], [0, 1], [0, 0]],
  [[0, 1], [1, 1], [0, 0], [1, 0]]
]

def add(pos, part)
  [pos[0] + part[0], pos[1] + part[1]]
end

def collides?(rock, map, dir)
  rock = move(rock, dir)
  rock.any? { |pos| map[pos] || pos.first < 0 || pos.first > 6 || pos.last < 0 }
end

def move(rock, dir)
  rock.map { |pos| add(pos, dir) }
end

def height(map)
  map.empty? ? 0 : map.keys.map(&:last).max + 1
end

def outline(map)
  positions = map.keys
  heights = (0..6).map { |col|
    positions.select { |pos| pos.first == col }.map(&:last).max || 0
  }
  heights.map { |h| h - heights.min }
end

cache = {}

steps = 1000000000000
moves_i = 0
rocks_count = 0
dummy_height = 0

loop do
  rock = shapes[rocks_count % shapes.size]
  rock = move(rock, [2, height(map) + 3])

  loop do
    # handle jets
    move = moves[moves_i % moves.size]
    moves_i += 1

    dir = (move == "<") ? [-1, 0] : [1, 0]
    rock = move(rock, dir) unless collides?(rock, map, dir)

    # move down
    dir = [0, -1]
    if collides?(rock, map, dir)
      rock.each { |pos| map[pos] = true }
      rocks_count += 1
      break
    else
      rock = move(rock, dir)
    end
  end

  key = [outline(map),
    moves_i % moves.length,
    rocks_count % shapes.length]

  if cache[key] && dummy_height == 0
    old_height, old_pieces = cache[key]
    interval = rocks_count - old_pieces
    dummy_height = ((steps - rocks_count) / interval) * (height(map) - old_height)
    rocks_count = steps - ((steps - rocks_count) % interval)
  else
    cache[key] = [height(map), rocks_count]
  end

  break if rocks_count == steps
end

p height(map) + dummy_height
