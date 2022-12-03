lines = File.readlines("input.txt", chomp: true)

def priority(char)
  # a = 97, A = 65
  (char.ord > 96) ? char.ord - 96 : char.ord - 38
end

p lines.each_slice(3)
  .map { |g| g.map(&:chars).inject(:&).first }
  .map { |badge| priority(badge) }
  .sum
