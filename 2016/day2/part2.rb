instructions = File.open('input.txt').readlines
$keys = [
  nil, nil, 1, nil, nil,
  nil, 2, 3, 4, nil,
  5, 6, 7, 8, 9,
  nil, 'A', 'B', 'C', nil,
  nil, nil, 'D', nil, nil
]

def get(x, y)
  $keys[y * 5 + x]
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

  get(*out) && out.all? { |e| e >= 0 && e < 5 } ? out : pos
end

pos = [0, 2]
instructions.each do |line|
  line.chomp.chars.each do |c|
    pos = go(pos, c)
  end

  print get(*pos)
end
