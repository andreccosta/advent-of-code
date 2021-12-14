polymer, rules_list = File.read("input.txt").split("\n\n")

rules = rules_list
  .split("\n")
  .map { |l| l.split(" -> ") }
  .to_h

def step(rules, polymer)
  out = polymer.clone

  polymer.chars.each_cons(2).with_index do |part, i|
    out.insert(i + i + 1, rules[part.join])
  end

  out
end

10.times do
  polymer = step(rules, polymer)
end

freq = polymer.chars.tally.values
pp freq.max - freq.min
