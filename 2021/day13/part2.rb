require 'set'

contents = File.read('input.txt')

top, bottom = contents.split("\n\n")
dots = top.split("\n").map { |c| c.split(',').map(&:to_i) }
instructions = bottom.split("\n")

def fold(dots, axis, fold)
  dots = dots.map do |pos|
    x, y = *pos

    next pos unless
      axis == 'x' && x > fold || axis == 'y' && y > fold

    axis == 'x' ? [fold_coord(x, fold), y] : [x, fold_coord(y, fold)]
  end

  dots.to_set
end

def fold_coord(coord, fold)
  fold - (coord - fold)
end

instructions.each do |instruction|
  _, axis, fold = *instruction.match(/fold along ([x,y])=(\d+)/)
  dots = fold(dots, axis, fold.to_i)
end

max_x = dots.map(&:first).max
max_y = dots.map(&:last).max

dots_arr = Array.new(max_y + 1) { Array.new(max_x + 1, '  ') }

dots.each do |pos|
  x, y = *pos
  dots_arr[y][x] = '##'
end

dots_arr.each { |line| p line.join }
