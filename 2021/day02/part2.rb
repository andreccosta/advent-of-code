lines = File.readlines('input.txt', chomp: true)

pos = [0, 0, 0]

commands = {
  "forward" => [1, 0, 0],
  "down" => [0, 0, 1],
  "up" => [0, 0, -1]
}

lines.each do |l|
  cmd, size = l.split

  diff = commands[cmd].map { |x| x * size.to_i }

  if cmd == 'forward'
    diff[1] += pos[2] * size.to_i
  end

  pos = pos.zip(diff).map(&:sum)
end

p pos[0] * pos[1]
