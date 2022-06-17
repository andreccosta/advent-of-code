require 'set'

lines = File.readlines('input.txt', chomp: true)

two = 0
three = 0

lines.each do |l|
  counts = l.chars.tally.values

  two += 1 if counts.include?(2)
  three += 1 if counts.include?(3)
end

p two * three
