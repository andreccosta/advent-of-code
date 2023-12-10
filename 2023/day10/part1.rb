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

  return if nx < 0 || ny < 0 || nx >= lines[0].length || ny >= lines.length
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
    x = start_x
    y = start_y
    steps = 0
    finished = false

    until finished
      steps += 1
      finished, (x, y), dir = step(lines, x, y, dir)

      break if !finished && !dir
    end

    return steps if finished
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

start_x, start_y = find_start(lines)
steps = start(lines, start_x, start_y)

p steps / 2
