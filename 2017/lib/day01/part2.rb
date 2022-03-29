module DayOne
  class PartTwo
    def self.solve(input)
      arr = input.chars
      half = input.size / 2
      sum = 0

      arr.each_with_index do |n, i|
        sum += n.to_i if arr[(i + half) % input.size] == n
      end

      sum
    end
  end
end
