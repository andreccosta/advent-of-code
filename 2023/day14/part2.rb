lines = File.readlines("input.txt", chomp: true)
  .map(&:chars)

def tilt(lines, dir)
  case dir
  when "n"
    (0...lines.length).each do |y|
      (0...lines[y].length).each do |x|
        char = lines[y][x]

        next unless char == "O"

        ny = y
        ny -= 1 while ny > 0 && lines[ny - 1][x] == "."

        lines[ny][x], lines[y][x] = "O", "." if ny != y
      end
    end
  when "s"
    (0...lines.length).reverse_each do |y|
      (0...lines[y].length).each do |x|
        char = lines[y][x]

        next unless char == "O"

        ny = y
        ny += 1 while ny < lines.length - 1 && lines[ny + 1][x] == "."

        lines[ny][x], lines[y][x] = "O", "." if ny != y
      end
    end
  when "e"
    (0...lines.length).each do |y|
      (0...lines[y].length).reverse_each do |x|
        char = lines[y][x]

        next unless char == "O"

        nx = x
        nx += 1 while nx < lines[y].length - 1 && lines[y][nx + 1] == "."

        lines[y][nx], lines[y][x] = "O", "." if nx != x
      end
    end
  when "w"
    (0...lines.length).each do |y|
      (0...lines[y].length).each do |x|
        char = lines[y][x]

        next unless char == "O"

        nx = x
        nx -= 1 while nx > 0 && lines[y][nx - 1] == "."

        lines[y][nx], lines[y][x] = "O", "." if nx != x
      end
    end
  end
end

def total_load(map)
  map.each_with_index.sum do |line, y|
    line.count("O") * (map.length - y)
  end
end

def cycle(lines)
  %w[n w s e].each { |dir| tilt(lines, dir) }
end

seen = {}
iterations = 1000000000

cycles = 0

loop do
  cycles += 1
  key = lines.hash

  if seen[key]
    start = seen[key]

    diff = (iterations - cycles) % (cycles - start)
    diff.times { cycle(lines) }

    break
  else
    cycle(lines)
    seen[key] = cycles
  end
end

p total_load(lines)
