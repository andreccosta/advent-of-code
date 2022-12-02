lines = File.readlines("input.txt", chomp: true)

OPPONENT_PICK = {
  "A" => 1, # Rock
  "B" => 2, # Paper
  "C" => 3 # Scissors
}

def pick(opponent, outcome)
  opp_pick = OPPONENT_PICK[opponent]

  case outcome
  when "X" # Loose
    (opp_pick - 1 <= 0) ? 3 : opp_pick - 1
  when "Y" # Draw
    opp_pick
  when "Z" # Win
    (opp_pick == 3) ? 1 : opp_pick + 1
  end
end

def score(opponent, you)
  opp_pick = OPPONENT_PICK[opponent]
  my_pick = you

  game_score = if (my_pick == 1 && opp_pick == 3) ||
      (my_pick == 2 && opp_pick == 1) ||
      (my_pick == 3 && opp_pick == 2)
    6
  elsif my_pick == opp_pick
    3
  else
    0
  end

  game_score + my_pick
end

scores = lines.map do |line|
  opp_pick, outcome = line.split
  score(opp_pick, pick(opp_pick, outcome))
end

p scores.sum
