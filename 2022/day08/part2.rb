LINES = File.readlines("input.txt", chomp: true)
  .map { _1.chars.map(&:to_i) }

DIRS = [[0, -1], [1, 0], [0, 1], [-1, 0]]

COLUMNS = LINES.first.length
ROWS = LINES.length

def get(pos)
  x, y = *pos

  if x >= 0 && y >= 0 && x < COLUMNS && y < ROWS
    LINES[y][x]
  end
end

def move(pos, diff)
  pos.zip(diff).map { |x| x.reduce(:+) }
end

def viewing_score(height, pos)
  distances = DIRS.map do |dir|
    next_pos = pos
    viewing_distance = 0

    loop do
      next_pos = move(next_pos, dir)
      adj_height = get(next_pos)

      break if adj_height.nil?

      viewing_distance += 1
      break if adj_height >= height
    end

    viewing_distance
  end

  distances.reduce(:*)
end

max = LINES.map.with_index do |row, y|
  row.map.with_index do |height, x|
    viewing_score(height, [x, y])
  end.max
end.max

p max
