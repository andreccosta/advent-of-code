lines = File.readlines("input.txt", chomp: true)

cycle = 1
x = 1
width = 40
screen = Array.new(6 * width) { " " }

def set_screen_pixel(screen, cycle, x)
  screen_pos = (cycle - 1) % 40

  if (screen_pos - x).abs <= 1
    screen[cycle - 1] = "█"
  end
end

lines.each do |line|
  instr, arg = line.split

  set_screen_pixel(screen, cycle, x)
  cycle += 1

  if instr == "addx"
    set_screen_pixel(screen, cycle, x)
    cycle += 1

    x += arg.to_i
  end
end

screen.each_slice(width) { |s| p s.join }
