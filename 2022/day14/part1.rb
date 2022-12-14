lines = File.readlines("input.txt", chomp: true)

map = {}
from = [500, 0]
MOVES = [[0, 1], [-1, 1], [1, 1]]

def move(pos, diff)
  [pos[0] + diff[0], pos[1] + diff[1]]
end

def step(map, pos)
  MOVES.each do |dir|
    new_pos = move(pos, dir)
    return new_pos if !map[new_pos]
  end

  pos
end

def to_path(from, to)
  from_x, from_y = from
  to_x, to_y = to

  from_x, to_x = to_x, from_x if from_x > to_x
  from_y, to_y = to_y, from_y if from_y > to_y

  (from_x..to_x).to_a.product((from_y..to_y).to_a)
end

lines.each do |line|
  parts = line.split(" -> ")

  parts.each_cons(2) do |from, to|
    from = from.split(",").map(&:to_i)
    to = to.split(",").map(&:to_i)

    to_path(from, to).each do |x|
      map[x] = "#"
    end
  end
end

threshold = map.keys.map(&:last).max
sand_at_rest = 0

loop do
  # generate new sand
  pos = from

  break if loop do
    new_pos = step(map, pos)

    if new_pos == pos
      map[pos] = "o"
      sand_at_rest += 1
      break false
    elsif new_pos[1] >= threshold
      break true
    end

    pos = new_pos
  end
end

p sand_at_rest
