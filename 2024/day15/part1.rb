require 'matrix'

DIRS = {
  "^" => Vector[-1, 0],
  "v" => Vector[1, 0],
  ">" => Vector[0, 1],
  "<" => Vector[0, -1]
}

lines = File.readlines("input.txt", chomp: true)

def move(map, pos, dir)
  return false if map[pos] == '#'
  return true if map[pos] == '.'
  return false unless move(map, pos + dir, dir)

  map[pos + dir], map[pos] = map[pos], '.'

  true
end

map, moves = lines.slice_when { |l| l.empty? }.to_a
curr = nil

map = map.each.with_index.with_object({}) { |(line, y), map|
  line.chars.each.with_index { |c, x|
    if c == '@'
      curr = Vector[y, x]
      map[Vector[y, x]] = '.'
    else
      map[Vector[y, x]] = c
    end
  }
}

moves.join.chars.each { |m|
  curr += DIRS[m] if move(map, curr + DIRS[m], DIRS[m])
}

p map.select { |k,v| v == 'O' }.keys.sum { |k| k[0] * 100 + k[1]}
