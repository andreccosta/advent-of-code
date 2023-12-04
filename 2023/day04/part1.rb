lines = File.readlines("input.txt", chomp: true)

points = lines.map do |line|
  _, content = line.split(":")
  winning, have = content.split(" | ").map { _1.split.map(&:to_i) }
  common = (have & winning).size

  (common > 0) ? 2**(common - 1) : 0
end

p points.sum
