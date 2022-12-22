lines = File.readlines("input.txt", chomp: true)
numbers = lines.map(&:to_i)

KEY = 811589153

length = numbers.length
data = numbers.map { |i| i * KEY }.each_with_index.to_a
dup = data.dup

10.times do
  dup.each do |n, i|
    pos = data.index([n, i])
    n = n % (length - 1)

    n.times do
      next_pos = (pos + 1) % length
      data[pos], data[next_pos] = data[next_pos], data[pos]

      pos = next_pos
    end
  end
end

data = data.map(&:first)
pos = data.index(0)

p [1000, 2000, 3000].map { |i| data[(pos + i) % length] }.sum
