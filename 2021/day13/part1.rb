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

instruction = instructions.first
_, axis, fold = *instruction.match(/fold along ([x,y])=(\d+)/)

dots = fold(dots, axis, fold.to_i)
pp dots.size
