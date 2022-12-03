lines = File.readlines("input.txt", chomp: true)

def priority(char)
  # a = 97, A = 65
  (char.ord > 96) ? char.ord - 96 : char.ord - 38
end

p lines
  .map { |line| line.chars.each_slice(line.length / 2).map(&:to_a) }
  .map { |first, second| (first & second).first }
  .map { |badge| priority(badge) }
  .sum
