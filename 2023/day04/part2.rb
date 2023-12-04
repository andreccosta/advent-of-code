lines = File.readlines("input.txt", chomp: true)

cards = {}

lines.each_with_index do |line, i|
  _, content = line.split(":")
  winning, have = content.split(" | ").map { _1.split.map(&:to_i) }

  cards[i + 1] = [(have & winning).size, 1]
end

cards.each do |k, (common, x)|
  next unless common > 0

  x.times do
    (k + 1..k + common).each { cards[_1][-1] += 1 }
  end
end

p cards.values.map(&:last).sum
