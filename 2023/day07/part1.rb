lines = File.readlines("input.txt", chomp: true)

CARDS_VALUE = {
  A: 14,
  K: 13,
  Q: 12,
  J: 11,
  T: 10
}

def type(hand)
  if five_of_a_kind?(hand)
    7
  elsif four_of_a_kind?(hand)
    6
  elsif full_house?(hand)
    5
  elsif three_of_a_kind?(hand)
    4
  elsif two_pair?(hand)
    3
  elsif one_pair?(hand)
    2
  else
    1
  end
end

def five_of_a_kind?(hand)
  hand.chars.all? { |c| c == hand[0] }
end

def four_of_a_kind?(hand)
  hand.chars.uniq.any? { |c| hand.count(c) == 4 }
end

def full_house?(hand)
  hand.chars.tally.values.sort == [2, 3]
end

def three_of_a_kind?(hand)
  hand.chars.uniq.any? { |c| hand.count(c) == 3 }
end

def two_pair?(hand)
  hand.chars.uniq.count { |c| hand.count(c) == 2 } == 2
end

def one_pair?(hand)
  hand.chars.uniq.count { |c| hand.count(c) == 2 } == 1
end

def to_card_values(hand)
  hand.chars.map { |c| CARDS_VALUE[c.to_sym] || c.to_i }
end

def to_card_str(hand_chars)
  hand_chars.map { |c| CARDS_VALUE.key(c)&.to_s || c }.join
end

hand_types = []
bids = lines.map { |line| line.split }.to_h

bids.keys.each do |hand|
  idx = type(hand) - 1

  hand_types[idx] ||= []
  hand_types[idx] << to_card_values(hand)
end

rank = 1
score = 0

hand_types.compact.each do |type_hands|
  type_hands.sort.each do |hand|
    bid = bids[to_card_str(hand)]

    score += rank * bid.to_i
    rank += 1
  end
end

p score
