lines = File.readlines("input.txt", chomp: true)

PIPES = {
  "|" => "ns",
  "-" => "ew",
  "L" => "ne",
  "J" => "nw",
  "7" => "sw",
  "F" => "se",
  "S" => "nsew"
}

def find_start(lines)
  lines.each.with_index do |line, y|
    line.chars.each.with_index do |char, x|
      return [x, y] if char == "S"
    end
  end
end

def move(x, y, dir)
  case dir
  when "n"
    [x, y - 1]
  when "s"
    [x, y + 1]
  when "e"
    [x + 1, y]
  when "w"
    [x - 1, y]
  else
    raise
  end
end

def next_dir(lines, x, y, dir)
  nx, ny = move(x, y, dir)

  return if nx < 0 || ny < 0
  return if nx >= lines[0].length || ny >= lines.length
  return if lines[ny][nx] == "."

  dirs = PIPES[lines[y][x]]
  ndirs = PIPES[lines[ny][nx]]

  if dir == "n"
    ndirs.delete("s") if dirs.include?("n") && ndirs.include?("s")
  elsif dir == "s"
    ndirs.delete("n") if dirs.include?("s") && ndirs.include?("n")
  elsif dir == "e"
    ndirs.delete("w") if dirs.include?("e") && ndirs.include?("w")
  elsif dir == "w"
    ndirs.delete("e") if dirs.include?("w") && ndirs.include?("e")
  end
end

def start(lines, x, y)
  start_x = x
  start_y = y

  "nsew".chars.each do |dir|
    pos = Set.new
    pos << [start_x, start_y]

    x = start_x
    y = start_y
    steps = 0
    finished = false

    until finished
      steps += 1
      finished, (x, y), dir = step(lines, x, y, dir)

      break if !finished && !dir

      pos << [x, y] if !finished
    end

    if finished
      return pos
    end
  end
end

def step(lines, x, y, dir)
  nx, ny = move(x, y, dir)

  return [true] if lines[ny][nx] == "S"

  if (ndir = next_dir(lines, x, y, dir))
    return [false, [nx, ny], ndir]
  end

  [false, nil, nil]
end

def area(loop_positions)
  sum = 0

  loop = loop_positions.to_a
  loop.push(loop[0])
  loop.each_cons(2) do |(x1, y1), (x2, y2)|
    sum += x1 * y2 - x2 * y1
  end

  (sum / 2).abs - (loop.length / 2) + 1
end

start_x, start_y = find_start(lines)
loop_positions = start(lines, start_x, start_y)

p area(loop_positions)
