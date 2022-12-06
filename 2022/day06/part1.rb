input = File.read("input.txt").chomp

input.chars.each_cons(4).with_index do
  if _1.uniq.length == _1.length
    p _2 + 4
    break
  end
end
