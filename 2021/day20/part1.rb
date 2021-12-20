algorithm, image = File.read("input.txt").split("\n\n")
algorithm = algorithm.chars.map { |c| c == "#" ? 1 : 0 }
lines = image.split("\n")

DIRS = [-1, 0, 1].flat_map do |y|
  [-1, 0, 1].map do |x|
    [x, y]
  end
end

map = Hash.new(0)
lines.each_with_index do |l, y|
  l.chars.each_with_index do |c, x|
    map[[x, y]] = c == '#' ? 1 : 0
  end
end

def range(map)
  range_x = map.keys.map(&:first).minmax
  range_y = map.keys.map(&:last).minmax

  [*range_x, *range_y]
end

def print(map)
  min_x, max_x, min_y, max_y = range(map)

  (min_y - 4..max_y + 4).each do |y|
    line = ""
    (min_x - 4..max_x + 4).each do |x|
      line << (map[[x, y]] == 1 ? "#" : ".")
    end
    p line
  end
end

def grid(map, pos)
  DIRS.map do |dir|
    n_pos = pos.zip(dir).map { |x| x.reduce(:+) }
    map[n_pos]
  end
end

def enhance(map, algo)
  default = algo[0]
  min_x, max_x, min_y, max_y = range(map)

  new_map = Hash.new(map.default == 0 ? default : 0)

  (min_y - 1..max_y + 1).each do |y|
    (min_x - 1..max_x + 1).each do |x|
      k = [x, y]
      idx = grid(map, k).join.to_i(2)

      new_map[k] = algo[idx]
    end
  end

  new_map
end

2.times do
  map = enhance(map, algorithm)
end

p map.values.sum
