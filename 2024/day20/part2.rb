require 'matrix'

DIRS = [
  Vector[-1, 0],
  Vector[1, 0],
  Vector[0, 1],
  Vector[0, -1]
]

lines = File.readlines("input.txt", chomp: true)
grid = {}
start, finish = nil
walls = Set.new

lines.each_with_index.with_object({}) { |(line, y), grid|
  line.chars.each_with_index { |c, x|
    v = Vector[x, y]
    grid[v] = c

    if c == 'S'
      start = v
    elsif c == 'E'
      finish = v
    elsif c == '#'
      walls << v
    end
  }
}

step_counts = { start => 0 }
visited = Set.new

queue = [start]
until queue.empty?
  pos = queue.shift
  visited << pos
  steps = step_counts[pos]

  DIRS.each { |d|
    n_pos = pos + d
    next if walls.include?(n_pos) || visited.include?(n_pos)

    step_counts[n_pos] = steps + 1
    queue.push(n_pos)
  }
end

max_cheat = 20
points = step_counts.keys.to_set

p step_counts.sum { |pos, steps|
  points.delete(pos).count{ |n_pos|
    cheat = (n_pos[0] - pos[0]).abs + (n_pos[1] - pos[1]).abs
    next if cheat > max_cheat
    step_counts[n_pos] - (steps + cheat) >= 100
  }
}
