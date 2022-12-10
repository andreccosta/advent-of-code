lines = File.readlines("input.txt", chomp: true)

cycle = 1
x = 1
screen = Array.new(6 * 40) { "." }

def set_screen_pixel(screen, cycle, x)
  sprite_pos = x % 40
  screen_pos = (cycle - 1) % 40

  screen[cycle - 1] = if (screen_pos - sprite_pos).abs > 1
    "."
  else
    "#"
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

screen.each_slice(40) { |s| p s.join }
