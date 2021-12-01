lines = File.readlines('input.txt', chomp: true)
  .map(&:to_i)

count = 0

(3..lines.length - 1).each do |i|
  count += 1 if lines[i-2..i].sum > lines[i-3..i-1].sum
end

p count