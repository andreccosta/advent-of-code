polymer = File.read('input.txt').chomp

stack = []

polymer.each_char do |char|
  if !stack.empty? && stack.last.downcase == char.downcase && stack.last != char
    stack.pop
  else
    stack.push(char)
  end
end

puts stack.join.size
