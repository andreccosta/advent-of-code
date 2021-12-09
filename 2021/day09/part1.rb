LINES = File.readlines('input.txt', chomp: true)
  .map { |x| x.chars.map(&:to_i) }

DIRS = [[0, -1], [1, 0], [0, 1], [-1, 0]]

def get(pos)
  x, y = *pos
  LINES[y][x] if x >= 0 && y >= 0 && x < LINES[0].length && y < LINES.length
end

def move_pos(pos, diff)
  pos.zip(diff).map { |x| x.reduce(:+) }
end

def lowest?(height, pos)
  DIRS.all? do |dir|
    adj_pos = move_pos(pos, dir)
    adj_height = get(adj_pos)

    adj_height.nil? || height < adj_height
  end
end

heights = []
LINES.each_with_index do |row, y|
  row.each_with_index do |height, x|
    heights << height + 1 if lowest?(height, [x, y])
  end
end

p heights.sum
