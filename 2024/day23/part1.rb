lines = File.readlines('input.txt', chomp: true)
nodes = lines.map { it.split("-") }

adj = Hash.new { |h, k| h[k] = Set.new }
nodes.each { |a, b| adj[a] << b; adj[b] << a }

nodes = adj.keys.sort
connections = []
k = 3

build = lambda do |connection, candidates|
  connections << connection and return if connection.size == k

  candidates.each_with_index do |node, i|
    next_candidates = candidates[i+1..-1].select { |n|
      adj[node].include?(n) && connection.all? { |c| adj[n].include?(c) }
    }

    build.call(connection + [node], next_candidates)
  end
end

build.call([], nodes)

p connections.count { it.any? { it.start_with?("t") } }
