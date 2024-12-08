lines = File.readlines("input.txt", chomp: true)
max_x = lines.first.length
max_y = lines.length

antennas = {}

lines.each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
     if char != "."
      antennas[char] ||= []
      antennas[char] << [x, y]
     end
  end
end

antinodes = Set.new

antennas.each do |_, coords|
  coords.combination(2).each do |(x1, y1), (x2, y2)|
    x_diff = (x2 - x1)
    y_diff = (y2 - y1)

    antinode_x, antinode_y = x1 - x_diff, y1 - y_diff
    if antinode_x.between?(0, max_x - 1) && antinode_y.between?(0, max_y - 1)
      antinodes << [antinode_x, antinode_y]
    end

    antinode_x, antinode_y = x2 + x_diff, y2 + y_diff
    if antinode_x.between?(0, max_x - 1) && antinode_y.between?(0, max_y - 1)
      antinodes << [antinode_x, antinode_y]
    end
  end
end

p antinodes.size

