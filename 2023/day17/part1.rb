require "algorithms"

lines = File.readlines("input.txt", chomp: true)
  .map { _1.chars.map(&:to_i) }

START = [0, 0]
FINISH = [lines[0].size - 1, lines.size - 1]
DIRS = [[0, 1], [1, 0], [0, -1], [-1, 0]]
OPPOSITE_DIRS = DIRS.rotate(-2)

NUM_ROWS = lines.size
NUM_COLS = lines[0].size

def find_best_path(lines)
  visited = Set.new
  queue = Containers::PriorityQueue.new
  queue.push([START, 0, 1, nil], 0)

  until queue.empty?
    pos, cost, consecutive, last_dir = queue.pop
    return cost if pos == FINISH

    next unless visited.add?([pos, consecutive, last_dir])

    opposite_dir = last_dir && OPPOSITE_DIRS[DIRS.index(last_dir)]

    DIRS.each do |dir|
      next if dir == opposite_dir

      new_consecutive = (dir == last_dir) ? consecutive + 1 : 1
      next if new_consecutive > 3

      new_pos = [pos[0] + dir[0], pos[1] + dir[1]]

      next if new_pos[0] < 0 || new_pos[1] < 0 ||
        new_pos[0] >= NUM_COLS || new_pos[1] >= NUM_ROWS

      new_cost = cost + lines[new_pos[1]][new_pos[0]]
      queue.push([new_pos, new_cost, new_consecutive, dir], -new_cost)
    end
  end

  nil
end

p find_best_path(lines)
