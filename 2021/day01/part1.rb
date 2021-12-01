lines = File.readlines('input.txt')
  .map(&:chomp)
  .map(&:to_i)

prev = nil
increased_count = 0

lines.each do |l|
  increased_count += 1 if !prev.nil? && l > prev
  prev = l
end

p increased_count