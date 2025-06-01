line = File.read("input.txt")
data = line.split.map(&:to_i)

def parse(data)
  q_child, q_metadata = data.shift(2)
  child_values = q_child.times.map { parse(data) }

  metadata = data.shift(q_metadata)

  if q_child == 0
    metadata.sum
  else
    metadata.sum { child_values[it - 1] || 0 }
  end
end

puts parse(data)
