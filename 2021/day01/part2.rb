lines = File.readlines('input.txt')
  .map(&:chomp)
  .map(&:to_i)

prev = nil
increased_count = 0

lines.each.with_index(2) do |l, i|
  curr = lines[i-2..i].sum
  increased_count += 1 if !prev.nil? && curr > prev
  prev = curr
end

p increased_count