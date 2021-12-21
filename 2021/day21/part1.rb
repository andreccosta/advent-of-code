positions = File.read("input.txt")
  .split("\n")
  .map { |s| s.split(": ").last.to_i }

scores = [0, 0]
positions = positions.map(&:pred)

$i = 1
$count = 0

def roll_die
  out = $i
  $i += 1 % 100
  $count += 1
  out
end

while true
  p0_die = 3.times.map { roll_die }.sum
  positions[0] = (positions[0] + p0_die) % 10
  scores[0] += positions[0] + 1
  break if scores[0] >= 1000

  p1_die = 3.times.map { roll_die }.sum
  positions[1] = (positions[1] + p1_die) % 10
  scores[1] += positions[1] + 1
  break if scores[1] >= 1000
end

p scores.min * $count
