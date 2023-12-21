map = File.readlines("input.txt", chomp: true)
  .map { |line| line.chars }

DIRS = [[0, 1], [1, 0], [0, -1], [-1, 0]]
COLS = map[0].size
ROWS = map.size

def step(map, queue)
  queue.flat_map do |pos|
    DIRS.filter_map do |dir|
      next_pos = [pos[0] + dir[0], pos[1] + dir[1]]

      next if next_pos[0] < 0 || next_pos[1] < 0 ||
        next_pos[0] >= COLS || next_pos[1] >= ROWS
      next if map[next_pos[1]][next_pos[0]] == "#"

      next_pos
    end
  end.to_set
end

start = nil
steps = 64

map.each_with_index do |row, y|
  row.each_with_index do |col, x|
    start = [x, y] if col == "S"
  end
end

queue = [[start[0], start[1]]]
steps.times { queue = step(map, queue) }

p queue.size
