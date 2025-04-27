lines = File.readlines("input.txt", chomp: true)

wires = {}
operations = []
highest_z = "z00"

def process(op, op1, op2)
  case op
  when "AND" then op1 & op2
  when "OR" then op1 | op2
  when "XOR" then op1 ^ op2
  end
end

lines.each do |line|
  if line.include?(":")
    wire, value = line.split(": ")
    wires[wire] = value.to_i
  elsif line.include?("->")
    op1, op, op2, _, res = line.split(" ")
    operations << [op1, op, op2, res]

    highest_z = res if res.start_with?("z") && res[1..].to_i > highest_z[1..].to_i
  end
end

until operations.empty?
  op1, op, op2, res = operations.shift
  if wires.key?(op1) && wires.key?(op2)
    wires[res] = process(op, wires[op1], wires[op2])
  else
    operations << [op1, op, op2, res]
  end
end

bits = wires.keys.sort.reverse
  .filter { it.start_with?("z") }
  .map { wires[it].to_s }

p bits.join.to_i(2)
