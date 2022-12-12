require "set"

DIRS = [
  [1, 0],
  [-1, 0],
  [0, 1],
  [0, -1]
]

map = {}
finish = nil
starts = []

def move(x, y, dir)
  [x + dir[0], y + dir[1]]
end

lines = File.readlines("input.txt", chomp: true)

lines.each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    map[[x, y]] = if char == "S" || char == "a"
      starts << [x, y]
      0
    elsif char == "E"
      finish = [x, y]
      25
    else
      char.ord - "a".ord
    end
  end
end

steps = starts.map do |start|
  queue = [[start, 0]]
  visited = Set.new

  while queue.any?
    node, steps = queue.shift

    break steps if node == finish

    children = DIRS
      .map { |dir| move(*node, dir) }
      .filter { |p| map.include?(p) }
      .filter { |p| map[p] - map[node] <= 1 }
      .filter { |p| visited.add?(p) }

    queue.push(*children.zip([steps + 1] * children.size))
  end
end

p steps.compact.min
