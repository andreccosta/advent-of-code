file = File.open('input.txt')
lines = file.readlines.map(&:chomp)

count = 0

lines.each do |l|
  sides = l.split.map(&:to_i).sort

  if sides[0..1].sum > sides[2]
    count += 1
  end
end

p count