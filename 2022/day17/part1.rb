require "set"

moves = File
  .readlines("input.txt", chomp: true)
  .first

map = Set[
  [0, 0],
  [1, 0],
  [2, 0],
  [3, 0],
  [4, 0],
  [5, 0],
  [6, 0]
]

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

def wall_collision_check(map, shape, pos)
  coords = shape.map { |part| add(pos, part) }
  coords.any? { |coord| map.include?(coord) } || coords.any? { |coord| coord.first < 0 || coord.first > 6 }
end

def collision_check(map, shape, pos)
  coords = shape.map { |part| add(pos, part) }
  coords.any? { |coord| map.include?(coord) }
end

def print_map(map)
  min_x, max_x = map.keys.map(&:first).minmax
  min_y, max_y = map.keys.map(&:last).minmax

  (min_y..max_y).to_a.reverse.map do |y|
    p (min_x..max_x).map { |x| map[[x, y]] || "." }.join("")
  end
end

def add_rock_to_map(map, shape, pos)
  coords = shape.map { |part| add(pos, part) }
  coords.each do |coord|
    map << coord
  end
end

steps = 2022
moves_i = 0

steps.times do |i|
  rock = shapes[i % shapes.size]
  max_y = map.map(&:last).max

  pos = [2, max_y + 4]

  loop do
    # handle jets
    move = moves[moves_i % moves.size]
    moves_i += 1

    new_pos = pos.dup
    new_pos[0] += (move == "<") ? -1 : 1

    # check for wall collisions
    if wall_collision_check(map, rock, new_pos)
      new_pos = pos # reset position
    end

    # move down
    new_pos[1] -= 1

    if collision_check(map, rock, new_pos)
      new_pos[1] += 1
      add_rock_to_map(map, rock, new_pos)
      break
    end

    pos = new_pos
  end
end

p map.map(&:last).max
