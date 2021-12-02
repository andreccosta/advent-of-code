lines = File.readlines('input.txt', chomp: true)

pos = [0, 0]

commands = {
  "forward" => [1, 0],
  "down" => [0, 1],
  "up" => [0, -1]
}

lines.each do |l|
  cmd, size = l.split

  diff = commands[cmd].map { |x| x * size.to_i }
  pos = pos.zip(diff).map(&:sum)
end

p pos.reduce { |c, x| c * x }
