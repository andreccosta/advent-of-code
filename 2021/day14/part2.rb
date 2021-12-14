polymer, rules_list = File.read("input.txt").split("\n\n")

rules = rules_list
  .split("\n")
  .map { |l| l.split(" -> ") }
  .to_h

def generate(rules, pair)
  result = rules[pair]
  [pair[0] + result, result + pair[1]]
end

def step(rules, counts)
  new_counts = Hash.new(0)

  counts.each do |k, v|
    generate(rules, k).each { |p| new_counts[p] += v }
  end

  new_counts
end

# turn string into pairs
pairs = polymer.chars.each_cons(2).map { |a, b| a + b }
counts = pairs.tally

40.times do
  counts = step(rules, counts)
end

single_char_counts = Hash.new(0)
counts.each { |k, v| single_char_counts[k[0]] += v }

# add the last char missing (unaccounted for when cleaning up pairs)
single_char_counts[polymer[-1]] += 1

freq = single_char_counts.values
p freq.max - freq.min
