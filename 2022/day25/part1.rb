lines = File.readlines("input.txt", chomp: true)

MAFS = {
  "2" => 2,
  "1" => 1,
  "0" => 0,
  "-" => -1,
  "=" => -2
}

def to_snafu(line)
  line.chars.map.with_index { |char, index|
    MAFS[char] * 5**(line.length - index - 1)
  }.sum
end

def from_snafu(snafu)
  out = ""
  until snafu == 0
    snafu += 2
    out << MAFS.invert[snafu % 5 - 2]
    snafu /= 5
  end
  out.reverse
end

total = lines.sum { |line| to_snafu(line) }

p total
p from_snafu(total)
