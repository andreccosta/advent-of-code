lines = File.readlines('input.txt', chomp: true)

steps = Hash.new { |h, k| h[k] = [] }

lines.each do |line|
  dep, step = line.match(/Step (\w+) must be finished before step (\w+)/).captures

  steps[step] << dep
  steps[dep]
end

str = ''
time = 0
workers = {}

until str.size == steps.size
  completed = workers.select { |_, remaining| remaining == 1 }.keys

  completed.each do |step|
    str << step
    workers.delete(step)
  end

  workers.transform_values! { |v| v - 1 }

  next_steps = steps.keys
                    .reject { str.include?(it) || workers.keys.include?(it) }
                    .select { steps[it].all? { str.include?(it) } }
                    .sort

  next_steps.each do |next_step|
    break if workers.size >= 5

    workers[next_step] = (next_step.ord - 'A'.ord) + 61
  end

  time += 1 if workers.any?
end

puts time
