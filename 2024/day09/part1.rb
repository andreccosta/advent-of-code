lines = File.readlines("input.txt", chomp: true)
blocks = lines.first.chars

id = 0
compressed = []
space = false

blocks.each do |c|
  c.to_i.times { compressed << (space ? "." : id) }
  id += 1 unless space
  space = !space
end

pos = compressed.length - 1
compressed.each_with_index do |c, i|
  break if i >= pos
  next if c != "."

  pos -= 1 while compressed[pos] == "." && pos > i
  compressed[i], compressed[pos] = compressed[pos], "."
  pos -= 1
end

p compressed.each_with_index.sum { |c, i| c == "." ? 0 : c * i }
