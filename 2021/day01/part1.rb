lines = File.readlines('input.txt', chomp: true)
  .map(&:to_i)

count = 0

(1..lines.length - 1).each do |i|
  count += 1 if lines[i] > lines[i - 1]
end

p count
