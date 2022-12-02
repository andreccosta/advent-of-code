lines = File.readlines("input.txt", chomp: true)

OPPONENT_PICK = {
  "A" => 1, # Rock
  "B" => 2, # Paper
  "C" => 3 # Scissors
}

MY_PICK = {
  "X" => 1, # Rock
  "Y" => 2, # Paper
  "Z" => 3 # Scissors
}

def score(opponent, you)
  opp_pick = OPPONENT_PICK[opponent]
  my_pick = MY_PICK[you]

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
  score(*line.split)
end

p scores.sum
