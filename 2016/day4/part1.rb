lines = File.readlines("input.txt").map(&:chomp)

def checksum(name)
  chars = Hash.new(0)

  name.chars.uniq.each { |c| chars[c] = name.count c }
  chars.sort_by { |letter, freq| [-freq, letter] }
    .map(&:first)
    .take(5)
    .join
end

reg = /^([-a-z]+)-([0-9]+)\[([a-z]+)\]$/
sum = 0

lines.each do |line|
  name, sector, in_checksum = *reg.match(line)[1..3]
  checksum = checksum(name.gsub("-", ""))
  sum += sector.to_i if checksum == in_checksum
end

p sum