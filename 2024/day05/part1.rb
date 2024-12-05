lines = File.read("input.txt")

rules, pages = lines.split("\n\n").map { |group| group.split("\n") }
rules = rules.map { |r| r.split("|").map(&:to_i) }

def is_valid?(rules, values)
  rules.each do |a, b|
    if values.include?(a) && values.include?(b)
      return false if values.index(a) > values.index(b)
    end
  end

  true
end

r = pages.sum do |page|
  values = page.split(",").map(&:to_i)

  if is_valid?(rules, values)
    values[values.length / 2]
  else
    0
  end
end

p r
