line = File.read('input.txt', chomp: true)
positions = line.split(',').map(&:to_i)

def fuel(arr, target)
  out = arr.tally.map do |k, v|
    (0..(k - target).abs).inject(:+) * v
  end

  out.sum
end

p positions.map.with_index { |p, i|
  fuel(positions, i)
}.min
