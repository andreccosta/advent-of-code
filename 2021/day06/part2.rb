line = File.read('input.txt', chomp: true)
initial_state = line.split(',').map(&:to_i)
days = 256

$zero_counts = []

def step(state)
  state.flat_map { |s| s.zero? ? [6, 8] : s - 1 }
end

@cache = {}
def zeros(day)
  @cache[day] ||= day < 7 ? $zero_counts[day] : zeros(day - 9) + zeros(day - 7)
end

state = initial_state.clone
7.times do
  state = step(state)
  $zero_counts << state.count(0)
end

# zeros from the previous day is how many are added in the next
p initial_state.length + (0..days - 2).sum { |i| zeros(i) }
