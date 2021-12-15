require 'set'

DIRS = [[0, -1], [1, 0], [0, 1], [-1, 0]]

lines = File.readlines("input.txt", chomp: true)

map = lines.flat_map.with_index { |line, row|
  line.chars.map(&:to_i).map.with_index { |risk, col|
    [[col, row], risk]
  }
}.to_h

start = [0, 0]
target = [lines.length * 5 - 1, lines.length * 5 - 1]
queue = [[start, 0]]
seen = Set.new

# 5x initial map
size = lines.length
initial = map.clone

5.times do |row|
  5.times do |col|
    next if row == 0 && col == 0

    inc_x, inc_y = size * col, size * row
    inc = col + row

    initial.each do |k, v|
      x, y = *k
      new_pos = [x + inc_x, y + inc_y]
      map[new_pos] = (v + inc - 1) % 9 + 1
    end
  end
end

while true
  pos, risk = queue.shift

  break if pos == target

  neighbors = DIRS.map { |dir| pos.zip(dir).map { |x| x.reduce(:+) } }
    .select { |p| map[p] }

  neighbors.each do |p|
    next unless seen.add?(p)
    queue.push [p, risk + map[p]]
  end

  queue.sort_by! &:last
end

p risk
