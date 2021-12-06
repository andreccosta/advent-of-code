line = File.read('input.txt', chomp: true)
state = line.split(',').map(&:to_i)

def step(state)
  state.flat_map { |s| s.zero? ? [6, 8] : s - 1 }
end

80.times do
  state = step(state)
end

p state.length
