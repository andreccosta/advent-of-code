file = File.open('input.txt')
lines = file.readlines.map(&:chomp)

count = 0

def triangle?(sides)
  sides.sort!
  sides[0..1].sum > sides[2]
end

three_sides = [[],[],[]]

lines.each do |l|
  sides = l.split.map(&:to_i)

  sides.each_with_index do |s, i|
    t_sides = three_sides[i]
    t_sides << s

    if t_sides.size == 3
      count += 1 if triangle?(t_sides)
      t_sides.clear
    end
  end
end

p count