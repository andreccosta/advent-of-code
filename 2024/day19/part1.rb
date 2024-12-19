patterns, designs = File.read("input.txt").split("\n\n")
patterns = patterns.split(", ")
designs = designs.split("\n")

p designs.count { |design| design =~ /^#{Regexp.union(*patterns)}+$/ }
