DIRS = [
  [0, -1],
  [1, 0],
  [0, 1],
  [-1, 0]
]

lines = File.readlines("input.txt", chomp: true)

map = lines.each_with_index.with_object({}) { |(line, y), g|
  line.chars.each_with_index { |c, x|
    g[[x, y]] = c.to_i
  }
}

def dfs(map, pos)
  curr = map[pos]
  return 1 if curr == 9

  DIRS.sum { |d|
    dx, dy = d
    n_pos = [pos[0] + dx, pos[1] + dy]

    next 0 if map[n_pos] != curr + 1
    dfs(map, n_pos)
  }
end

puts map.select { |k, v| v==0 }.keys.sum { |k| dfs(map, k) }
