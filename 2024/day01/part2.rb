lines = File.readlines("input.txt", chomp: true)

list_a, list_b = lines.map { |l| l.split.map(&:to_i) }.transpose
p list_a.sum { |a| a * list_b.count(a) }
