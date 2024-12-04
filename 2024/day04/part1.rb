DIRS = [
  [0, 1],
  [0, -1],
  [-1, 0],
  [1, 0],
  [-1, 1],
  [1, 1],
  [-1, -1],
  [1, -1],
]
WORD = "XMAS"

lines = File.readlines("input.txt", chomp: true)
count = 0

def get(lines, pos)
  x, y = pos
  return nil if x < 0 || y < 0 || y >= lines.length || x >= lines.first.length
  lines[y][x]
end

def move(pos, dir)
  [pos[0] + dir[0], pos[1] + dir[1]]
end

lines.each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    next unless char == WORD[0]

    DIRS.each do |diff|
      pos = [x, y]

      (1..WORD.length).each do |i|
        pos = move(pos, diff)
        break if pos.nil?

        char = get(lines, pos)
        break if char != WORD[i]

        count += 1 if i == WORD.length - 1
      end

    end
  end
end

puts count
