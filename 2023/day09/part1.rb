lines = File.readlines("input.txt", chomp: true)
  .map { _1.split.map(&:to_i) }

r = lines.sum do |line|
  x = []

  until line.all? { _1.zero? }
    x << line[-1]
    line = line.each_cons(2).map { _2 - _1 }
  end

  x.sum
end

p r
