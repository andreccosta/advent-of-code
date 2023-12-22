positions = File.readlines("input.txt", chomp: true)
  .map { |line| line.split("~").map { |x| x.split(",").map(&:to_i) } }

bricks = positions.map do |((sx, sy, sz), (fx, fy, fz))|
  (sx..fx).flat_map do |x|
    (sy..fy).flat_map do |y|
      (sz..fz).map do |z|
        [x, y, z]
      end
    end
  end
end.sort_by { |brick| brick.map(&:last).min }

grid = bricks.flat_map { |brick|
  brick.map { |pos| [pos, brick] }
}.to_h

bricks.each { |brick|
  until brick.any? { |pos| pos.last == 1 }
    new_pos = brick.map { |pos| [pos[0], pos[1], pos[2] - 1] }
    break if new_pos.any? { |x, y, z| grid[[x, y, z]] && grid[[x, y, z]] != brick }

    brick.each { |(x, y, z)|
      grid.delete([x, y, z])
      grid[[x, y, z - 1]] = brick
    }

    brick.map! { |pos| [pos[0], pos[1], pos[2] - 1] }
  end
}

above = bricks.map { |brick|
  [brick, brick.map { |(x, y, z)|
    grid[[x, y, z + 1]] if grid[[x, y, z + 1]] && grid[[x, y, z + 1]] != brick
  }.compact.uniq]
}.to_h

below = bricks.map { |brick|
  [brick, brick.map { |x, y, z|
    grid[[x, y, z - 1]] if grid[[x, y, z - 1]] && grid[[x, y, z - 1]] != brick
  }.compact.uniq]
}.to_h

p bricks.sum { |brick|
  to_fall = [brick].to_set
  queue = above[brick].to_a

  while (t = queue.shift)
    next if to_fall.include?(t)
    next unless below[t].all? { to_fall.include?(_1) }

    to_fall << t
    queue += above[t].to_a
  end

  to_fall.size - 1
}
