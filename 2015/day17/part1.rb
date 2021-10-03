lines = File.readlines('input.txt')
containers = lines.map { |l| l.strip!.to_i }
target = 150

count = 0

(1..containers.length()).each do |i|
  containers.combination(i).each do |comb|
    count += 1 if comb.sum == target
  end
end

puts count
