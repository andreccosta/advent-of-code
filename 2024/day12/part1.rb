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

    DIRS.each { |dir|
      queue << (curr + dir) if(map[curr + dir] == map[curr])
    }
  end
}

r = regions.sum do |r|
  r.size * r.sum { |p| DIRS.count { |d| !r.include?(p+d) } }
end

p r
