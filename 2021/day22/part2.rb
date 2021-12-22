lines = File.readlines("input.txt", chomp: true)

Cube = Struct.new(:x1, :x2, :y1, :y2, :z1, :z2) do
  def valid?
    x1 < x2 && y1 < y2 && z1 < z2
  end

  def intersection(cube)
    Cube.new(
      [x1, cube.x1].max,
      [x2, cube.x2].min,
      [y1, cube.y1].max,
      [y2, cube.y2].min,
      [z1, cube.z1].max,
      [z2, cube.z2].min
    )
  end

  def intersect?(cube)
    intersection(cube).valid?
  end

  def volume
    (x2 - x1) * (y2 - y1) * (z2 - z1)
  end

  def to_s
    "#{x1}, #{x2} - #{y1}, #{y2} - #{z1}, #{z2}"
  end
end

data = lines.map do |l|
  state, coords = l.split
  [state, Cube.new(*coords.split(",").flat_map { |r|
    range = eval(r.split("=").last)
    [range.begin, range.end + 1]
  })]
end

cubes = {}

fit_cube = lambda do |new_cube, to_add|
  cubes.keys.each do |cube|
    next unless new_cube.intersect?(cube)

    cubes.delete(cube)
    xs = [cube.x1, cube.x2, new_cube.x1, new_cube.x2].uniq.sort
    ys = [cube.y1, cube.y2, new_cube.y1, new_cube.y2].uniq.sort
    zs = [cube.z1, cube.z2, new_cube.z1, new_cube.z2].uniq.sort
    xs.each_cons(2) do |x1, x2|
      ys.each_cons(2) do |y1, y2|
        zs.each_cons(2) do |z1, z2|
          target_cube = Cube.new(x1, x2, y1, y2, z1, z2)
          cubes[target_cube] = true if to_add[target_cube, cube]
        end
      end
    end
  end
end

data.each do |state, new_cube|
  fit_cube[new_cube, ->(slice, old_cube) { old_cube.intersect?(slice) && !new_cube.intersect?(slice) }]
  cubes[new_cube] = true if state == "on"
end

p cubes.keys.sum(&:volume)
