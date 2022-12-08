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

def is_visible?(height, pos)
  DIRS.any? do |dir|
    next_pos = pos
    result = true

    loop do
      next_pos = move(next_pos, dir)
      adj_height = get(next_pos)

      break result if adj_height.nil?
      break false if height <= adj_height
    end
  end
end

total = LINES.map.with_index do |row, y|
  row.map.with_index do |height, x|
    is_visible?(height, [x, y])
  end.count(true)
end.sum

p total
