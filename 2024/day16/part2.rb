require "algorithms"

lines = File.readlines("input.txt", chomp: true)

DIRS = [[0, 1], [1, 0], [0, -1], [-1, 0]]

map = {}
start = nil
finish = nil

lines.each.with_index do |line, y|
  line.chars.each.with_index do |c, x|
    map[[x, y]] = c if c != "#"
    start = [x, y] if c == "S"
    finish = [x, y] if c == "E"
  end
end

queue = Containers::PriorityQueue.new
queue.push([start, 0, 1, [0]], 0)
visited = { [start, 1] => 0 }
visited.default = Float::INFINITY
found = false
best = Set.new

until queue.empty?
  pos, score, last_dir, path = queue.pop
  break if found && score > found

  if pos == finish
    found = score
    best += path
    next
  end

  DIRS.each.with_index do |dir, i|
    next if dir == DIRS[last_dir - 2]

    new_pos = pos.zip(dir).map(&:sum)
    next unless map[new_pos]

    new_score = score + (i == last_dir ? 1 : 1001)

    if new_score <= visited[[new_pos, i]]
      visited[[new_pos, i]] = new_score
      queue.push([new_pos, new_score, i, path + [new_pos]], -new_score)
    end
  end
end

p best.size
