original_polymer = File.read('input.txt').chomp

totals = ('a'..'z').map do |letter|
  polymer = original_polymer.delete(letter + letter.upcase)

  stack = []

  polymer.each_char do |char|
    if !stack.empty? && stack.last.downcase == char.downcase && stack.last != char
      stack.pop
    else
      stack.push(char)
    end
  end

  [letter, stack.join.size]
end.to_h

puts totals.min_by { |_, v| v }.last
