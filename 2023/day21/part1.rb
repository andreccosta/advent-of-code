map = File.readlines("input.txt", chomp: true)
  .map { |line| line.chars }

DIRS = [[0, 1], [1, 0], [0, -1], [-1, 0]]
COLS = map[0].size
ROWS = map.size

def step(map, queue)
  queue.product(DIRS).map { |pos, dir| pos.zip(dir).map(&:sum) }
    .reject { |next_pos|
      next_pos[0] < 0 || next_pos[1] < 0 || next_pos[0] >= COLS || next_pos[1] >= ROWS ||
        map[next_pos[1]][next_pos[0]] == "#"
    }
    .uniq
end

start = map.flatten.index("S")&.divmod(map.first.size)

queue = [start]
64.times { queue = step(map, queue) }

p queue.size
