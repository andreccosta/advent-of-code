require 'set'

lines = File.readlines('input.txt', chomp: true)

freq = 0
seen = Set.new

loop do
  break unless lines.each do |l|
    freq += l.to_i

    break if seen.include?(freq)

    seen << freq
  end
end

p freq
