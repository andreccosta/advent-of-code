lines = File.readlines("input.txt", chomp: true)
numbers = lines.map(&:to_i)

length = numbers.length
data = numbers.each_with_index.to_a

data.dup.each do |n, i|
  pos = data.index([n, i])
  n = n % (length - 1)

  n.times do
    next_pos = (pos + 1) % length
    data[pos], data[next_pos] = data[next_pos], data[pos]

    pos = next_pos
  end
end

data = data.map(&:first)
pos = data.index(0)

p [1000, 2000, 3000].map { |i| data[(pos + i) % length] }.sum
