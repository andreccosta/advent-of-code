class Range
  def intersection(other)
    return nil if max < other.begin || other.max < self.begin

    [self.begin, other.begin].max..[max, other.max].min
  end
end

input = File.read("input.txt")

seeds, *maps = input.split("\n\n")
seeds = seeds.split(": ").last.split.map(&:to_i)
maps = maps.map { |str|
  str.split("\n")[1..].map { _1.split.map(&:to_i) }
}
ranges = seeds.each_slice(2).map { |s, l| s..(s + l) }

maps.each do |entries|
  next_ranges = []

  until ranges.empty?
    range = ranges.shift
    found = false

    entries.each do |dst, src, len|
      intersect = range.intersection(src..(src + len))

      if intersect
        found = true
        delta = dst - src
        next_ranges.push((intersect.begin + delta)..(intersect.end + delta))

        if intersect.begin > range.begin
          ranges.push(range.begin..(intersect.begin - 1))
        end

        if intersect.end < range.end
          ranges.push((intersect.end + 1)..range.end)
        end
      end
    end

    next_ranges.push(range) if !found
  end

  ranges = next_ranges
end

p ranges.map(&:begin).min
