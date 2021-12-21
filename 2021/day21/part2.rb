positions = File.read("input.txt")
  .split("\n")
  .map { |s| s.split(": ").last.to_i }

scores = [0, 0]
positions = positions.map(&:pred)

$rolls = [1, 2, 3]
$rolls = $rolls.product($rolls, $rolls).map(&:sum)
$cache = {}

def search(positions, scores, turn = 0)
  k = [positions, scores, turn]
  return $cache[k] if $cache[k]

  return [1, 0] if scores[0] >= 21
  return [0, 1] if scores[1] >= 21

  wins = $rolls.map do |roll|
    new_positions = positions.clone
    new_scores = scores.clone
    new_positions[turn] = (new_positions[turn] + roll) % 10
    new_scores[turn] += new_positions[turn] + 1
    search(new_positions, new_scores, turn == 0 ? 1 : 0)
  end

  $cache[k] = [wins.map(&:first).sum, wins.map(&:last).sum]
end

p search(positions, scores).max
