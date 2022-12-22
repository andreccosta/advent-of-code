require "debug"

lines = File.read("input.txt")
  .split("\n\n")
  .map { _1.split("\n") }

board, paths = lines
map = {}

board.each_with_index do |row, y|
  row.chars.each_with_index do |c, x|
    next if c.empty? || c == " "

    map[[x, y]] = c
  end
end

instructions = paths.last.scan(/\d+|\w/)

DIRS = "RDLU"
MOVES = [
  [1, 0],
  [0, 1],
  [-1, 0],
  [0, -1]
]

def move(pos, dir)
  x, y = pos
  dx, dy = MOVES[dir]

  [x + dx, y + dy]
end

pos = [board.first.index("."), 0]
dir = 0

instructions.each do |instruction|
  if instruction.match?(/\d+/)
    moves = instruction.to_i

    moves.to_i.times do
      next_pos = move(pos, dir)
      up_next = map[next_pos]

      if up_next == "."
        pos = next_pos
        next
      end

      break if up_next == "#"

      # else wrap around
      case dir
      when 0
        min_x = map
          .select { |k, _| k[1] == pos[1] }
          .map { |k, _| k[0] }
          .min

        next_pos = [min_x, pos[1]]
        up_next = map[next_pos]
      when 1
        min_y = map
          .select { |k, _| k[0] == pos[0] }
          .map { |k, _| k[1] }
          .min

        next_pos = [pos[0], min_y]
        up_next = map[next_pos]
      when 2
        max_x = map
          .select { |k, _| k[1] == pos[1] }
          .map { |k, _| k[0] }
          .max

        next_pos = [max_x, pos[1]]
        up_next = map[next_pos]
      when 3
        max_y = map
          .select { |k, _| k[0] == pos[0] }
          .map { |k, _| k[1] }
          .max

        next_pos = [pos[0], max_y]
        up_next = map[next_pos]
      end

      if up_next == "."
        pos = next_pos
        next
      elsif up_next == "#"
        break
      end
    end
  else
    dir_diff = (instruction == "R") ? 1 : -1
    dir = (dir + dir_diff) % 4
  end
end

p 1000 * (pos[1] + 1) + 4 * (pos[0] + 1) + dir
