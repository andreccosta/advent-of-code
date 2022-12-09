lines = File.readlines("input.txt", chomp: true)

KNOTS_COUNT = 2
DIRS = {
  "R" => [1, 0],
  "L" => [-1, 0],
  "U" => [0, 1],
  "D" => [0, -1]
}

pos = KNOTS_COUNT.times.map { [0, 0] }

def move(pos, diff)
  [pos[0] + diff[0], pos[1] + diff[1]]
end

def move_to(pos, target_pos)
  pos_x, pos_y = *pos
  target_x, target_y = *target_pos

  return pos if (target_x - pos_x).abs < 2 &&
    (target_y - pos_y).abs < 2

  x_diff = target_x <=> pos_x
  y_diff = target_y <=> pos_y

  if x_diff != 0 || y_diff != 0
    return [pos_x + x_diff, pos_y + y_diff]
  end

  pos
end

uniq_pos = lines.flat_map do |line|
  dir, count = line.split

  count.to_i.times.map do
    # move head
    pos[0] = move(pos[0], DIRS[dir])

    # trailing knots
    (1..KNOTS_COUNT - 1).each do |i|
      pos[i] = move_to(pos[i], pos[i - 1])
    end

    pos.last.join(",")
  end.uniq
end.uniq

p uniq_pos.count
