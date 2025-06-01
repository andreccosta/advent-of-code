line = File.read("input.txt")
data = line.split.map(&:to_i)

def parse(data)
  q_child, q_metadata = data.shift(2)
  child_metadata = q_child.times.flat_map { parse(data) }.sum

  metadata = data.shift(q_metadata).sum

  child_metadata + metadata
end

puts parse(data)
