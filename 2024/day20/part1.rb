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

max_cheat = 2

p step_counts.sum { |pos, steps|
  (-max_cheat..max_cheat).sum { |dx|
    (-max_cheat..max_cheat).count { |dy|
      n_pos = pos + Vector[dx, dy]

      next if dx==0 && dy==0
      next if dx.abs + dy.abs > max_cheat
      next unless step_counts.key?(n_pos)

      step_counts[n_pos] - (steps + (dx.abs + dy.abs)) >= 100
    }
  }
}
