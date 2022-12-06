input = File.read("input.txt").chomp

input.chars.each_cons(14).with_index do
  if _1.uniq.length == _1.length
    p _2 + 14
    break
  end
end
