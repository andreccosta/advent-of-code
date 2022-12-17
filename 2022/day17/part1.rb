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

def collides?(map, rock, dir)
  rock = move(rock, dir)
  rock.any? { |pos| map[pos] || pos.first < 0 || pos.first > 6 || pos.last < 0 }
end

def move(rock, dir)
  rock.map { |pos| add(pos, dir) }
end

def height(map)
  map.empty? ? 0 : map.keys.map(&:last).max + 1
end

steps = 2022
moves_i = 0

steps.times do |i|
  rock = shapes[i % shapes.size]
  rock = move(rock, [2, height(map) + 3])

  loop do
    # handle jets
    move = moves[moves_i % moves.size]
    moves_i += 1

    dir = (move == "<") ? [-1, 0] : [1, 0]
    rock = move(rock, dir) unless collides?(map, rock, dir)

    # move down
    dir = [0, -1]
    if collides?(map, rock, dir)
      rock.each { |pos| map[pos] = true }
      break
    else
      rock = move(rock, dir)
    end
  end
end

p map.keys.map(&:last).max + 1
