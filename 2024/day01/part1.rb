lines = File.readlines("input.txt", chomp: true)

list_a, list_b = lines.map { |l| l.split.map(&:to_i) }.transpose.map(&:sort)
p list_a.zip(list_b).sum { |a,b| (a - b).abs }
