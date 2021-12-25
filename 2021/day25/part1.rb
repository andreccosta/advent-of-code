lines = File.readlines("input.txt", chomp: true)

HERDS = [">", "v"].freeze

max_y = lines.length - 1
max_x = lines[0].length - 1

map = {}
lines.each_with_index do |l, row|
  l.chars.each_with_index do |c, col|
    map[[col, row]] = c if c != '.'
  end
end

def dir(chr)
  chr == '>' ? [1, 0] : [0, 1]
end

def move(pos, dir)
  [pos[0] + dir[0], pos[1] + dir[1]]
end

def step(map, max_x, max_y)
  HERDS.each do |h|
    new_map = map.reject { |_, v| v == h }

    map.each do |pos, c|
      next if c != h

      new_pos = move(pos, dir(c))

      new_pos[0] = 0 if new_pos[0] > max_x
      new_pos[1] = 0 if new_pos[1] > max_y

      if map.key?(new_pos)
        new_map[pos] = c
      else
        new_map[new_pos] = c
      end
    end

    map = new_map
  end

  map
end

prev = nil
500.times do |i|
  map = step(map, max_x, max_y)

  if prev == map
    p i + 1
    break
  end

  prev = map
end
