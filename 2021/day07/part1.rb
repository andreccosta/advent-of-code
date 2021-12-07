line = File.read('input.txt', chomp: true)
positions = line.split(',').map(&:to_i)

def fuel(arr, target)
  arr.map { |x| (x - target).abs }.sum
end

def median(array)
  sorted = array.sort
  len = sorted.length
  (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
end

p fuel(positions, median(positions).to_i)
