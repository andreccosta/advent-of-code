instructions = File.readlines("input.txt", chomp: true)

stack = []
@checks = {}
@operations = instructions.map do |i|
  case i
  when /\Ainp ([w-z])\z/
    [
      :inp,
      Regexp.last_match(1).to_sym
    ]
  when /\A(add|mul|div|mod|eql) ([w-z]) ([w-z])\z/
    [
      Regexp.last_match(1).to_sym,
      Regexp.last_match(2).to_sym,
      Regexp.last_match(3).to_sym
    ]
  when /\A(add|mul|div|mod|eql) ([w-z]) (-?\d+)\z/
    [
      Regexp.last_match(1).to_sym,
      Regexp.last_match(2).to_sym,
      Regexp.last_match(3).to_i
    ]
  end
end

# split to repeated logic blocks
@operations.each_slice(@operations.length/14).with_index do |p, i|
  case p[4][2]
  when 1
    stack << [i, p[15][2]]
  when 26
    index, offset = stack.pop
    offset += p[5][2]
    @checks[i] = [index, offset]
  end
end

@limits = Array.new(14)
@checks.each do |i1, (i2, offset)|
  if offset.negative?
    i2, i1 = i1, i2
    offset = - offset
  end

  @limits[i1] = (1 + offset)..9
  @limits[i2] = 1..(9 - offset)
end

p @limits.map { |l| l.min }.inject(0) { |n, x| n * 10 + x }
