module DayTwo
  class PartOne
    def self.solve(input)
      input.lines.sum do |line|
        n = line.split.map(&:to_i)
        min, max = n.minmax
        max - min
      end
    end
  end
end
