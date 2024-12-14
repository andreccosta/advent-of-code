lines = File.readlines("input.txt", chomp: true)

MAX_X = 101
MAX_Y = 103
STEPS = 100

robots = lines.map { |line| line.scan(/-?\d+/).map(&:to_i) }
lsf = nil
step = 0

(MAX_X * MAX_Y).times do |i|
  quads = [0, 0, 0, 0]

  robots.map do |(x, y, dx, dy)|
    nx = (x + i * dx) % MAX_X
    ny = (y + i * dy) % MAX_Y

    if nx < MAX_X / 2 && ny < MAX_Y / 2
      quads[0] += 1
    elsif nx > MAX_X / 2 && ny < MAX_Y / 2
      quads[1] += 1
    elsif nx < MAX_X / 2 && ny > MAX_Y / 2
      quads[2] += 1
    elsif nx > MAX_X / 2 && ny > MAX_Y / 2
      quads[3] += 1
    end
  end

  sf = quads.reduce(&:*)

  if lsf.nil? || sf < lsf
    lsf = sf
    step = i
  end
end

p step
