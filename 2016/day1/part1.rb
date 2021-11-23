content = File.read("input.txt")
directions = content.split(", ")

pos = [0, 0]
h = 0
t = { 'R' => 1, 'L' => -1 }

dirs = [
  [0, 1],
  [1, 0],
  [0, -1],
  [-1, 0]
]

directions.each do |d|
  h = (h + t[d[0]]) % 4
  inc = d[1..-1].to_i
  pos = pos.zip(dirs[h].map { |c| c * inc }).map { |c| c.reduce(&:+) }
end

p pos.map(&:abs).reduce(&:+)
