packets = File
  .readlines("input.txt", chomp: true)
  .reject { _1.empty? }
  .map { eval(_1) }

packets << [[2]]
packets << [[6]]

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

packets.sort!(&method(:compare))

p (packets.index([[2]]) + 1) * (packets.index([[6]]) + 1)
