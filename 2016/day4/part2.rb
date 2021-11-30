lines = File.readlines("input.txt").map(&:chomp)

def checksum(name)
  chars = Hash.new(0)

  name.chars.uniq.each { |c| chars[c] = name.count c }
  chars.sort_by { |letter, freq| [-freq, letter] }
    .map(&:first)
    .take(5)
    .join
end

def decrypt(name, offset)
  alphabet = [*"a".."z"]
  result = name.chars.map do |c|
    if c == "-"
      " "
    else
      idx = (alphabet.index(c) + offset) % alphabet.size
      alphabet[idx]
    end
  end

  result.join
end

reg = /^([-a-z]+)-([0-9]+)\[([a-z]+)\]$/

lines.each do |line|
  name, sector, in_checksum = *reg.match(line)[1..3]
  checksum = checksum(name.gsub("-", ""))

  if checksum == in_checksum
    clear_name = decrypt(name, sector.to_i)

    if clear_name.include? "northpole"
      p sector
    end
  end
end