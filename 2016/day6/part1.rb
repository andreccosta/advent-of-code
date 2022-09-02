lines = File.readlines('input.txt', chomp: true)

p lines
  .map(&:chars)
  .transpose
  .map { |l| l.tally.max_by { |_, v|  v }.first }
  .join 

