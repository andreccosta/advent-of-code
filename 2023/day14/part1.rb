lines = File.readlines("input.txt", chomp: true)
  .map(&:chars)

def tilt(lines)
  lines.each_with_index do |line, y|
    line.each_with_index do |char, x|
      next unless char == "O"

      ny = y
      ny -= 1 while ny > 0 && lines[ny - 1][x] == "."

      lines[ny][x], lines[y][x] = "O", "." if ny != y
    end
  end
end

def total_load(map)
  map.each_with_index.sum do |line, y|
    line.count("O") * (map.length - y)
  end
end

p total_load(tilt(lines))
