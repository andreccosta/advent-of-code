space = File.readlines("input.txt", chomp: true)

def expand(space)
  expanded_space = []

  space.each do |row|
    expanded_space << row
    expanded_space << row if row.chars.all? { _1 == "." }
  end

  space = expanded_space
  expanded_space = []

  space.map(&:chars).transpose.each do |col|
    expanded_space << col
    expanded_space << col if col.all? { _1 == "." }
  end

  expanded_space.transpose.map(&:join)
end

def distance(x1, y1, x2, y2)
  (x1 - x2).abs + (y1 - y2).abs
end

space = expand(space)

pos = Set.new
space.each.with_index do |row, y|
  row.chars.each.with_index do |char, x|
    pos << [x, y] if char == "#"
  end
end

r = pos.to_a.combination(2).sum do |(x1, y1), (x2, y2)|
  distance(x1, y1, x2, y2)
end

p r
