lines = File.readlines("input.txt", chomp: true)

def to_range(part)
  Range.new(*part.split("-").map(&:to_i))
end

p lines.map { |line|
  first, second = line
    .split(",")
    .map { to_range(_1) }

  first.cover?(second) || second.cover?(first)
}.count(true)
