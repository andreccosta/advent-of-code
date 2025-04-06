module DayTwo
  class PartTwo
    def self.solve(input)
      input.lines.sum do |line|
        line.split.map(&:to_i).combination(2).each do |a, b|
          break a / b if a % b == 0
          break b / a if b % a == 0
        end
      end
    end
  end
end
