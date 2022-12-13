pairs = File
  .read("input.txt")
  .split("\n\n")
  .map { |lines|
    lines.split("\n").map { |line|
      eval(line)
    }
  }

def compare_array(left, right)
  return left <=> right if left.empty? || right.empty?

  zipped = if left.length >= right.length
    left.zip(right)
  else
    right.zip(left).map(&:reverse)
  end

  zipped.each do |l, r|
    return -1 if l.nil?
    return 1 if r.nil?

    c = compare(l, r)

    return c if c.is_a?(Integer) && c != 0
  end
end

def compare(left, right)
  if left.is_a?(Integer) && right.is_a?(Integer)
    left <=> right
  elsif left.is_a?(Array) && right.is_a?(Array)
    compare_array(left, right)
  elsif left.is_a?(Integer)
    compare_array([left], right)
  elsif right.is_a?(Integer)
    compare_array(left, [right])
  else
    raise "wat?"
  end
end

indexes = []
pairs.each_with_index do |pair, i|
  left, right = pair

  c = compare(left, right)

  indexes << i + 1 if c == -1
end

p indexes.sum
