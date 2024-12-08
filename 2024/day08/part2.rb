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

    antinodes << [x1, y1]
    antinodes << [x2, y2]

    antinode_x, antinode_y = x1, y1

    loop do
      antinode_x, antinode_y = antinode_x - x_diff, antinode_y - y_diff
      break unless antinode_x.between?(0, max_x - 1) && antinode_y.between?(0, max_y - 1)
      antinodes << [antinode_x, antinode_y]
    end

    antinode_x, antinode_y = x2, y2

    loop do
      antinode_x, antinode_y = antinode_x + x_diff, antinode_y + y_diff
      break unless antinode_x.between?(0, max_x - 1) && antinode_y.between?(0, max_y - 1)
      antinodes << [antinode_x, antinode_y]
    end
  end
end

p antinodes.size

