require "rb_heap"
require "set"

lines = File.readlines("input.txt", chomp: true)

BLIZZARD_DIRS = {
  "<": [-1, 0],
  ">": [1, 0],
  "v": [0, 1],
  "^": [0, -1]
}

DIRS = BLIZZARD_DIRS.values + [[0, 0]]

MAX_X = lines.first.length - 2
MAX_Y = lines.length - 2

start = [lines.first.index(".") - 1, -1]
finish = [lines.last.index(".") - 1, MAX_Y]

blizzards = []
walls = Set.new
walls << [0, -2]
walls << [MAX_X - 1, MAX_Y + 1]

lines.each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    if char == "#"
      walls << [x - 1, y - 1]
    elsif char != "."
      blizzards << [char, [x - 1, y - 1]]
    end
  end
end

BLIZZARDS_T = {}
def move_blizzards(blizzards, t)
  BLIZZARDS_T[t] ||= (blizzards.map do |d, pos|
    dir = BLIZZARD_DIRS[d.to_sym]

    [
      (pos.first + dir.first * t) % MAX_X,
      (pos.last + dir.last * t) % MAX_Y
    ]
  end).to_set
end

def find_path(time, start, finish, blizzards, walls)
  visited = {}
  queue = Heap.new { |a, b| a.first < b.first }
  queue.add([time, start])

  until queue.empty?
    t, pos = queue.pop

    break if pos == finish
    next if visited[[t, pos]]

    n_blizzards = move_blizzards(blizzards, t + 1)
    visited[[t, pos]] = t

    DIRS.each do |dx, dy|
      x, y = pos
      nx, ny = x + dx, y + dy

      neighbor = [nx, ny]
      next if n_blizzards.include?(neighbor) || walls.include?(neighbor)

      queue.add([t + 1, neighbor])
    end
  end
  t
end

time_first = find_path(0, start, finish, blizzards, walls)
time_second = find_path(time_first, finish, start, blizzards, walls)
time_third = find_path(time_second, start, finish, blizzards, walls)
p time_third
