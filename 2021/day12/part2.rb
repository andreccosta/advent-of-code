LINES = File.readlines('input.txt', chomp: true)

cave_map = Hash.new { |h, k| h[k] = [] }

LINES.each do |l|
  from, to = l.split('-')
  cave_map[from] << to
  cave_map[to] << from
end

def traverse(map, node, counter: Hash.new(0))
  counter = counter.clone
  counter[node] += 1 if node == node.downcase
  paths = []

  return [["end"]] if node == "end"

  map[node].each do |n|
    if n == n.downcase
      next if %w[start end].include?(n) && counter[n] > 0
      next if counter.values.any? { |v| v >= 2 } && counter[n] > 0
      next if counter[n] > 1
    end

    traverse(map, n, counter: counter)
      .each { |p| paths << [node] + p }
  end

  paths
end

p traverse(cave_map, "start").size
