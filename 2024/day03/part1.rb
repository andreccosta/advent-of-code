input = File.read("input.txt").chomp

puts input.scan(/mul\((\d+),(\d+)\)/).sum { |a, b|
  a.to_i * b.to_i
}
