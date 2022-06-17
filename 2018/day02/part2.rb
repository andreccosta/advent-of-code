require 'set'

lines = File.readlines('input.txt', chomp: true)

lines.combination(2) do |a, b|
  common = a.chars.zip(b.chars).filter_map { |x, y| x if x == y }.join
  next unless a.size - common.size == 1

  p common
  break
end
