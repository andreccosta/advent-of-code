input = File.read("input.txt").chomp

disabled = false

puts input.scan(/(do\(\))|(don't\(\))|mul\((\d+),(\d+)\)/).sum { |(do_match, dont_match, mul1, mul2)|
  if do_match
    disabled = false
    0
  elsif dont_match
    disabled = true
    0
  elsif !disabled
    mul1.to_i * mul2.to_i
  else
    0
  end
}
