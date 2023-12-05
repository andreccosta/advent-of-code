input = File.read("input.txt")

seeds, *maps = input.split("\n\n")
seeds = seeds.split(": ").last.split.map(&:to_i)
maps = maps.map { |str|
  str.split("\n")[1..].map { _1.split.map(&:to_i) }
}

maps.each do |entries|
  start_seeds = seeds.dup

  entries.each do |dst, src, len|
    start_seeds.each_with_index do |s, i|
      diff = s - src
      seeds[i] = dst + diff if diff >= 0 && diff < len
    end
  end
end

p seeds.min
