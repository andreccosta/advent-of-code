lines = File.readlines('input.txt', chomp: true)

steps = Hash.new { |h, k| h[k] = [] }

lines.each do |line|
  dep, step = line.match(/Step (\w+) must be finished before step (\w+)/).captures

  steps[step] << dep
  steps[dep]
end

str = ''

until str.size == steps.size
  str << steps.keys
              .reject { str.include?(it) }
              .select { steps[it].all? { str.include?(it) } }
              .min
end

puts str
