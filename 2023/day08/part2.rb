input = File.read("input.txt")

dirs, nodes = input.split("\n\n")

map = nodes.split("\n").map do |n|
  start, possible = n.split(" = ")

  [start, possible.gsub(/[()]/, "").split(", ")]
end.to_h

step = 0
nodes = map.keys
  .filter_map { |k| [k, 0] if k[-1] == "A" }

until nodes.all? { |v| v[0][-1] == "Z" }
  dir = dirs[step % dirs.size]
  step += 1

  nodes.each_with_index do |(node, _), i|
    next if node[-1] == "Z"

    nodes[i] = [map[node][(dir == "L") ? 0 : 1], step]
  end
end

p nodes.map(&:last).reduce(:lcm)
