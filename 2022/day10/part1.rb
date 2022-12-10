lines = File.readlines("input.txt", chomp: true)

cycle = 1
x = 1
signal_strengths = {}

lines.each do |line|
  instr, arg = line.split

  signal_strengths[cycle] = cycle * x
  cycle += 1

  if instr == "addx"
    signal_strengths[cycle] = cycle * x
    cycle += 1

    x += arg.to_i
  end
end

puts [20, 60, 100, 140, 180, 220].map { |c| signal_strengths[c] }.sum
