lines = File.readlines("input.txt", chomp: true)

def to_range(part)
  Range.new(*part.split("-").map(&:to_i))
end

p lines.map { |line|
  line
    .split(",")
    .map { to_range(_1).to_a }
    .inject(:&)
    .any?
}.count(true)
