line = File.read('input.txt', chomp: true)
state = line.split(',').map(&:to_i).tally

def step(state)
  new_state = Hash.new(0)

  state.each do |k, v|
    if k.zero?
      new_state[8] += v
      new_state[6] += v
    else
      new_state[k - 1] += v
    end
  end

  new_state
end

80.times do
  state = step(state)
end

p state.values.sum
