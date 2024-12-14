lines = File.readlines("input.txt", chomp: true)

MAX_X = 101
MAX_Y = 103
STEPS = 100

robots = lines.map { |line| line.scan(/-?\d+/).map(&:to_i) }
quads = [0, 0, 0, 0]

robots.map do |(x, y, dx, dy)|
  nx = (x + STEPS * dx) % MAX_X
  ny = (y + STEPS * dy) % MAX_Y

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

p quads.reduce(&:*)
