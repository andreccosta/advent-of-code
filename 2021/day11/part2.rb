LINES = File.readlines('input.txt', chomp: true)

DIRS = [-1, 0, 1]
       .repeated_permutation(2)
       .to_a - [0, 0]

energy = {}

LINES.each_with_index do |line, row|
  line.chars.each_with_index do |e, col|
    energy[[col, row]] = e.to_i
  end
end

def step(map)
  # energy increases by 1
  map.each { |pos, e| map[pos] = e + 1 }

  # 9 or higher flashes
  initial_flashes = map.filter { |_, e| e > 9 }.keys
  check_adjacent(map, initial_flashes) if initial_flashes.any?

  # count flashes this step
  flashes = map.count { |_, e| e > 9 }

  # reset flashed to 0
  map.each do |pos, e|
    map[pos] = 0 if e > 9
  end

  flashes
end

def check_adjacent(map, positions)
  flashed = [*positions]

  positions.each do |pos|
    check_adjacent_recur(map, pos, flashed)
  end
end

def check_adjacent_recur(map, pos, flashed)
  DIRS.each do |dir|
    adj_pos = pos.zip(dir).map { |x| x.reduce(:+) }
    next unless map.key?(adj_pos)

    map[adj_pos] += 1

    if map[adj_pos] > 9 && !flashed.include?(adj_pos)
      flashed << adj_pos
      check_adjacent_recur(map, adj_pos, flashed)
    end
  end

  map
end

1000.times do |i|
  if step(energy) == energy.size
    p i + 1
    break
  end
end
