lines = File.readlines("input.txt", chomp: true)

operations = []
highest_z = "z00"

lines.each do |line|
  if line.include?("->")
    op1, op, op2, _, res = line.split(" ")
    operations << [op1, op, op2, res]

    highest_z = res if res.start_with?("z") && res[1..].to_i > highest_z[1..].to_i
  end
end

wrong = Set.new

operations.each do |op1, op, op2, res|
  if res.start_with?("z") && op != "XOR" && res != highest_z
    wrong.add(res)
  end

  if op == "XOR"
    operations.each do |subop1, subop, subop2, _|
      wrong.add(res) if (res == subop1 || res == subop2) && subop == "OR"
    end

    wrong.add(res) if !["x", "y", "z"].any? { |char| [res, op1, op2].any? { it.start_with?(char) } }
  end

  if op == "AND" && !["x00"].include?(op1) && !["x00"].include?(op2)
    operations.each do |subop1, subop, subop2, _|
      wrong.add(res) if (res == subop1 || res == subop2) && subop != "OR"
    end
  end
end

p wrong.sort.join(",")
