require "set"

lines = File.readlines("input.txt", chomp: true)

DIRS = [
  [0, -1], # N
  [1, -1], # NE
  [-1, -1], # NW
  [0, 1], # S
  [1, 1], # SE
  [-1, 1], # SW
  [-1, 0], # W
  [-1, -1], # NW
  [-1, 1], # SW
  [1, 0], # E
  [1, -1], # NE
  [1, 1] # SE
]

ROUNDS = 10

def get(map, pos)
  map[pos]
end

def move(pos, dir)
  [pos[0] + dir[0], pos[1] + dir[1]]
end

def is_empty?(map, pos)
  get(map, pos).nil?
end

def print(map)
  min_x, max_x = map.keys.map(&:first).minmax
  min_y, max_y = map.keys.map(&:last).minmax

  (min_y..max_y).each do |y|
    line = ""
    (min_x..max_x).each do |x|
      line << (get(map, [x, y]).nil? ? "." : "#")
    end
    p line
  end
end

map = {}

lines.each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    map[[x, y]] = [] if char == "#"
  end
end

ROUNDS.times do |round|
  any_moved = false
  new_map = {}

  map.keys.each do |pos|
    # check neighbors
    empty = DIRS.all? { |dir| is_empty?(map, move(pos, dir)) }

    if empty
      new_map[pos] = pos
      next
    end

    # check sides
    found_empty_side = false

    DIRS
      .rotate(3 * round)
      .each_slice(3)
      .with_index do |side_dirs, i|
        if side_dirs.all? { |dir| is_empty?(map, move(pos, dir)) }
          found_empty_side = true
          new_pos = move(pos, side_dirs.first)

          # if collision put back
          if new_map.has_key?(new_pos)
            other_old_pos = new_map[new_pos]
            new_map.delete(new_pos)

            new_map[other_old_pos] = other_old_pos
            new_map[pos] = pos
          else
            new_map[new_pos] = pos
            any_moved = true
          end

          break
        end
      end

    new_map[pos] = pos unless found_empty_side
  end

  map = new_map

  break if !any_moved
end

min_x, max_x = map.keys.map(&:first).minmax
min_y, max_y = map.keys.map(&:last).minmax

area = ((max_x - min_x) + 1) * ((max_y - min_y) + 1)
count = area - map.keys.count

# print(map)
p count
