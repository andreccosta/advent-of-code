lines = File.readlines("input.txt", chomp: true)

def get(map, pos)
  x, y = pos
  map[y][x] unless x < 0 || y < 0 || x >= map[0].length || y >= map.length
end

def move(pos, dir)
  diff = {"r" => [1, 0], "l" => [-1, 0], "u" => [0, -1], "d" => [0, 1]}
  pos.zip(diff[dir]).map { |x| x.reduce(:+) }
end

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
      when "\\"
        dir = case dir
        when "r"
          "d"
        when "l"
          "u"
        when "u"
          "l"
        when "d"
          "r"
        end
      when "/"
        dir = case dir
        when "r"
          "u"
        when "l"
          "d"
        when "u"
          "r"
        when "d"
          "l"
        end
      end

      next_beams << [move(pos, dir), dir]
    end

    beams = next_beams
  end

  seen.uniq { _1.first }.size
end

p run(lines, [[[0, 0], "r"]])
