input = File.read("input.txt", chomp: true)

def hsh(str)
  str.each_char.inject(0) do |cv, c|
    (cv + c.ord) * 17 % 256
  end
end

p input.split(",").sum { hsh(_1) }
