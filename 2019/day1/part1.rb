lines = File.readlines('input.txt', chomp: true)

def fuel(mass)
  (mass / 3).floor - 2
end

pp lines.sum { |m| fuel(m.to_i) }

