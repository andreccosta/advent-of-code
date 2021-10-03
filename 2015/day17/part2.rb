lines = File.readlines('input.txt')
containers = lines.map { |l| l.strip!.to_i }
target = 150

count = 0
found = false

(1..containers.length()).each do |i|
  containers.combination(i).each do |comb|
    if comb.sum == target
      found = true
      count += 1
    end
  end

  break if found
end

puts count
