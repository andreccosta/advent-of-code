lines = File.readlines('input.txt', chomp: true)
p lines.sum { |l| l.to_i }

