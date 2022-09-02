lines = File.readlines('input.txt', chomp: true)

p lines
  .map(&:chars)
  .transpose
  .map { |l| l.tally.min_by { |_, v|  v }.first }
  .join 

