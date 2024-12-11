stones = File.read("input.txt").split.map(&:to_i).tally

75.times do
  next_stones = Hash.new { 0 }

  input = stones.each do |i,n|
    if i == 0
      next_stones[1] += n
    elsif i.to_s.size.even?
      d = i.to_s
      next_stones[d[0,d.size/2].to_i] += n
      next_stones[d[d.size/2..].to_i] += n
      next
    else
      next_stones[i*2024] += n
    end
  end

  stones = next_stones
end

p stones.values.sum
