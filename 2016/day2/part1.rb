instructions = File.open('input.txt').readlines
$keys = (1..9).to_a

def get(x, y)
  $keys[y * 3 + x]
end

def go(pos, dir)
  dirs = {
    "U" => [0, -1],
    "D" => [0, 1],
    "L" => [-1, 0],
    "R" => [1, 0]
  }

  diff = dirs[dir]
  out = pos.zip(diff).map(&:sum)
  out.all? { |e| e >= 0 && e < 3 } ? out : pos
end

pos = [1, 1]
instructions.each do |line|
  line.chomp.chars.each do |c|
    pos = go(pos, c)
  end

  print get(*pos)
end
