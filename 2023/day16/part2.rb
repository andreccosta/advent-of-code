lines = File.readlines("input.txt", chomp: true)

def get(map, pos)
  x, y = pos
  map[y][x] unless x < 0 || y < 0 || x >= map[0].length || y >= map.length
end

def move(pos, dir)
  diff = {
    "r" => [1, 0],
    "l" => [-1, 0],
    "u" => [0, -1],
    "d" => [0, 1]
  }

  pos[0] += diff[dir][0]
  pos[1] += diff[dir][1]
  pos
end

MIRRORS = {
  "\\" => {
    "r" => "d",
    "l" => "u",
    "u" => "l",
    "d" => "r"
  },
  "/" => {
    "r" => "u",
    "l" => "d",
    "u" => "r",
    "d" => "l"
  }
}

def run(map, beams)
  seen = Set.new

  while beams.size > 0
    next_beams = []

    beams.each do |pos, dir|
      next if seen.include?([pos, dir])

      cp = get(map, pos)
      next unless cp

      seen << [pos.dup, dir]

      case cp
      when "|"
        if dir == "r" || dir == "l"
          dir = "u"
          next_beams << [move(pos.dup, "d"), "d"]
        end
      when "-"
        if dir == "u" || dir == "d"
          dir = "r"
          next_beams << [move(pos.dup, "l"), "l"]
        end
      when "\\", "/"
        dir = MIRRORS[cp][dir]
      end

      next_beams << [move(pos, dir), dir]
    end

    beams = next_beams
  end

  seen.uniq { _1.first }.size
end

max_energy = 0

# top and bottom edges
(0..lines[0].length - 1).each do |x|
  max_energy = [max_energy, run(lines, [[[x, 0], "d"]])].max
  max_energy = [max_energy, run(lines, [[[x, lines.length - 1], "u"]])].max
end

# left and right edges
(0..lines.length - 1).each do |y|
  max_energy = [max_energy, run(lines, [[[0, y], "r"]])].max
  max_energy = [max_energy, run(lines, [[[lines[0].length, y], "r"]])].max
end

p max_energy
