lines = File.readlines('input.txt', chomp: true)
map = []

def walk(start, finish)
  line = [start]
  pos = start.clone

  while pos != finish
    pos[0] += pos[0] < finish[0] ? 1 : -1 if pos[0] != finish[0]
    pos[1] += pos[1] < finish[1] ? 1 : -1 if pos[1] != finish[1]

    line << pos.clone
  end

  line
end

lines.each do |l|
  start, finish = l.split(" -> ").map{ |g| g.split(",").map(&:to_i) }
  line = walk(start, finish) if start[0] == finish[0] || start[1] == finish[1]

  map.concat(line) if line
end

p map.tally.select { |_, v| v > 1 }.size
