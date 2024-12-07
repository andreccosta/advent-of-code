lines = File.readlines("input.txt", chomp: true)
sum = 0

lines.each do |line|
  target, parts = line.split(":")
  target = target.to_i
  parts = parts.split.map(&:to_i)

  found = false

  ["+", "*"].repeated_permutation(parts.size - 1) do |ops|
    total = parts[0]

    ops.zip(parts[1..]).each do |op, i|
      if op == "+"
        total += i
      else
        total *= i
      end
    end

    if total == target
      sum += target
      break
    end
  end
end

p sum
