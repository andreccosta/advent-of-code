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

prev = []

directions.each do |d|
  h = (h + t[d[0]]) % 4
  inc = d[1..-1].to_i

  (1..inc).each do
    pos  = pos.zip(dirs[h]).map { |c| c.reduce(&:+) }

    if prev.include? pos
      p pos.map(&:abs).reduce(&:+)
      exit
    end

    prev << pos
  end
end
