GUARD_DIRS = {
  "^" => [0, -1],
  ">" => [1, 0],
  "v" => [0, 1],
  "<" => [-1, 0],
}.freeze

lines = File.readlines("input.txt", chomp: true)

def get(lines, pos)
  x, y = pos
  return nil if x < 0 || y < 0 || y >= lines.length || x >= lines.first.length
  lines[y][x]
end

def move(pos, dir)
  [pos[0] + dir[0], pos[1] + dir[1]]
end

pos, dir = nil, nil

lines.each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    pos, dir = [x, y], char if char == "^"
  end
end

visited = Set.new([pos])

loop do
  next_pos = move(pos, GUARD_DIRS[dir])
  next_char = get(lines, next_pos)

  if next_char.nil?
    break
  elsif next_char == "#"
    dirs = GUARD_DIRS.keys
    dir = dirs[(dirs.index(dir) + 1) % dirs.length]
  else
    pos = next_pos
    visited.add(pos)
  end
end

p visited.size
