lines = File.readlines('input.txt', chomp: true)

def fuel(mass)
  (mass / 3).floor - 2
end

def total(mass, acc)
  f = fuel(mass)

  return acc unless f > 0

  total(f, acc + f)
end

pp lines.sum { |m| total(m.to_i, 0) }

