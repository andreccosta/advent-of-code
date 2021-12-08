lines = File.readlines('input.txt', chomp: true)

entries = lines.map do |l|
  parts = l.split(' | ')
  { signals: parts.first.split, outputs: parts.last.split }
end

outputs = entries.map { |e| e[:outputs] }.flatten
p outputs.filter { |v| [2, 3, 4, 7].include?(v.length) }.size
