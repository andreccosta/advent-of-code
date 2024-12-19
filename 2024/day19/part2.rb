patterns, designs = File.read("input.txt").split("\n\n")
patterns = patterns.split(", ")
designs = designs.split("\n")

@cache = {}

def count(design, patterns)
  return 1 if design.empty?

  @cache[design] ||= patterns.select { |p| design.start_with?(p) }
    .sum { |p| count(design[p.length..], patterns) }
end

p designs.sum { |design| count(design, patterns) }
