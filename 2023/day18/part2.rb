lines = File.readlines("input.txt", chomp: true)

DIRS = [[1, 0], [0, 1], [-1, 0], [0, -1]]

def edges(map)
  pos = [[0, 0]]
  edge_len = 0

  map.each do |line|
    _, _, color = line.split

    len = color[2, 5].to_i(16)
    dir = color[7, 1].to_i

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
