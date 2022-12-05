input = File.read("input.txt")
stacks_input, moves_input = input.split("\n\n").map { _1.split("\n") }

stacks_count = stacks_input.last.split.last.to_i

stacks = stacks_input[..-2].map do |line|
  parts = line.scan(/.{3}.?/)
    .map { _1.strip.empty? ? nil : _1.scan(/\w+/).first }

  parts.fill(nil, parts.length..stacks_count)
end

stacks = stacks.transpose.map { _1.reverse.compact }

moves_input.each do |line|
  count, from, to = line.scan(/\d+/)

  from_stack = stacks.at(from.to_i - 1)
  to_stack = stacks.at(to.to_i - 1)

  to_stack.push(*from_stack.pop(count.to_i).reverse)
end

p stacks.map(&:last).join
