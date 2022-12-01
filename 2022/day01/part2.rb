lines = File.readlines("input.txt", chomp: true)

p lines
  .chunk_while { |l| !l.empty? }.to_a
  .map { |a| a.map(&:to_i).sum }
  .sort
  .last(3)
  .sum
