lines = File.readlines("input.txt", chomp: true)

DIRS = {
  "U" => [0, -1],
  "D" => [0, 1],
  "L" => [-1, 0],
  "R" => [1, 0]
}

def edges(map)
  pos = [[0, 0]]
  edge_len = 0

  map.each do |line|
    dir, len, _ = line.split
    len = len.to_i
    edge_len += len

    dx, dy = DIRS[dir].map { _1 * len }

    pos.append([pos.last[0] + dx, pos.last[1] + dy])
  end

  [pos, edge_len]
end

def shoelace(pts, edgelen)
  pts.each_cons(2).sum { |p1, p2| p2[0] * p1[1] - p2[1] * p1[0] }.abs / 2 + edgelen / 2 + 1
end

p shoelace(*edges(lines))
