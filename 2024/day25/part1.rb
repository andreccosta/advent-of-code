input = File.read('input.txt')
patterns = input.split("\n\n").map { |b| b.split("\n").map(&:chars) }

parse = ->(lines) { lines.transpose.map { |column| column.count('#') } }
match = ->(k, l) { k.zip(l).all? { |ki, li| ki + li <= 7 } }

keys = patterns.filter { |p| p[0][0] == '.' }.map(&parse)
locks = patterns.filter { |p| p[0][0] == '#' }.map(&parse)

p keys.sum { |k| locks.count { |l| match.call(l, k) } }
