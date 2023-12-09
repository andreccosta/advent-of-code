lines = File.readlines("input.txt", chomp: true)
  .map { _1.split.map(&:to_i) }

r = lines.sum do |line|
  x = []

  until line.all? { _1.zero? }
    x << line[0]
    line = line.each_cons(2).map { _2 - _1 }
  end

  x.reverse.reduce(0) { |a, b| b - a }
end

p r
