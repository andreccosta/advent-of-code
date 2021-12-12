LINES = File.readlines('input.txt', chomp: true)

cave_map = Hash.new { |h, k| h[k] = [] }

LINES.each do |l|
  from, to = l.split('-')
  cave_map[from] << to
  cave_map[to] << from
end

def traverse(map, node, history: [])
  paths = []
  history += [node]

  return [["end"]] if node == "end"

  map[node].each do |n|
    next if n == n.downcase && history.include?(n)

    traverse(map, n, history: history)
      .each { |p| paths << [node] + p }
  end

  paths
end

p traverse(cave_map, "start").size
