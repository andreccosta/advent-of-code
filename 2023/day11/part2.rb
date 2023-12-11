space = File.readlines("input.txt", chomp: true)

LARGER = 1000000 - 1

def distance(x1, y1, x2, y2)
  (x1 - x2).abs + (y1 - y2).abs
end

pos = Set.new
space.each.with_index do |row, y|
  row.chars.each.with_index do |char, x|
    pos << [x, y] if char == "#"
  end
end

count = 0
space.each.with_index do |row, i|
  next unless row.chars.all? { _1 == "." }

  diff = LARGER * count
  count += 1

  pos.map! do |x, y|
    (y > i + diff) ? [x, y + LARGER] : [x, y]
  end
end

count = 0
space.map(&:chars).transpose.each.with_index do |col, i|
  next unless col.all? { _1 == "." }

  diff = LARGER * count
  count += 1

  pos.map! do |x, y|
    (x > i + diff) ? [x + LARGER, y] : [x, y]
  end
end

r = pos.to_a.combination(2).sum do |(x1, y1), (x2, y2)|
  distance(x1, y1, x2, y2)
end

p r
