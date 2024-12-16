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

def move_list(map, pos, dir)
  return false if pos.any? { map[_1] == '#' }
  return true if pos.all? { map[_1] == '.' }

  boxes = pos.map { |p|
    if map[p] == '['
      [p, p + DIRS['>']]
    elsif map[p] == ']'
      [p + DIRS['<'], p]
    end
  }.compact.flatten.uniq

  return false unless move_list(map, boxes.map { |p| p + dir }, dir)

  boxes.each { |p| map[p+dir], map[p] = map[p], '.' }

  true
end

map, moves = lines.slice_when { |l| l.empty? }.to_a
curr = nil

map = map.each_with_index.with_object({}) { |(line, y), map|
  line.chars.each_with_index { |c, x|
    if c == '@'
      curr = Vector[y, x*2]
      map[Vector[y, x*2]], map[Vector[y, x*2+1]] = '.', '.'
    elsif c == 'O'
      map[Vector[y, x*2]], map[Vector[y, x*2+1]] = '[', ']'
    else
      map[Vector[y, x*2]], map[Vector[y, x*2+1]] = c, c
    end
  }
}

moves.join.chars.each { |m|
  if([DIRS['>'], DIRS['<']].include?(DIRS[m]))
    curr += DIRS[m] if move(map, curr + DIRS[m], DIRS[m])
  else
    curr += DIRS[m] if move_list(map, [curr + DIRS[m]], DIRS[m])
  end
}

p map.select { |k,v| v == '[' }.keys.sum { |k| k[0] * 100 + k[1]}
