input = File.read("input.txt")

dirs, nodes = input.split("\n\n")

map = nodes.split("\n").map do |n|
  start, possible = n.split(" = ")

  [start, possible.gsub(/[()]/, "").split(", ")]
end.to_h

step = 0
node = "AAA"

while node != "ZZZ"
  dir = dirs[step % dirs.length]
  node = map[node][(dir == "L") ? 0 : 1]
  step += 1
end

p step
