require 'matrix'

DIRS = [
  Vector[0, 1],
  Vector[1, 0],
  Vector[0, -1],
  Vector[-1, 0]
]

lines = File.readlines("input.txt", chomp: true)

map = lines.each_with_index.with_object({}) { |(line, y), g|
  line.chars.each_with_index { |c, x|
    g[Vector[y, x]] = c
  }
}

seen = Set.new
regions = map.keys.each_with_object([]) { |p, regions|
  next if seen.include?(p)

  regions << Set.new
  queue = [p]

  while curr = queue.shift
    next if regions.last.include?(curr)
    regions.last << curr
    seen << curr

    DIRS.each { |d|
      queue << (curr + d) if(map[curr + d] == map[curr])
    }
  end
}

r = regions.sum { |r|
  r.size * r.each.with_object(Set.new) { |p, sides|
    DIRS.each { |dir|
      next if r.include?(p + dir)
      curr = p
      walk_dir =  Vector[dir[1], -dir[0]]

      while r.include?(curr + walk_dir) && !r.include?(curr + dir + walk_dir)
        curr += walk_dir
      end

      sides << [curr, dir]
    }
  }.size
}

p r
