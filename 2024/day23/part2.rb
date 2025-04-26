lines = File.readlines('input.txt', chomp: true)
nodes = lines.map { it.split("-") }

adj = Hash.new { |h, k| h[k] = Set.new }
nodes.each { |a, b| adj[a] << b; adj[b] << a }

nodes = adj.keys.sort
max_connection = []

build = lambda do |connection, candidates|
  max_connection = connection if connection.size > max_connection.size

  candidates.each_with_index do |node, i|
    next_candidates = candidates[i+1..-1].select { |n|
      adj[node].include?(n) && connection.all? { |c| adj[n].include?(c) }
    }

    build.call(connection + [node], next_candidates)
  end
end

build.call([], nodes)

p max_connection.sort.join(",")

