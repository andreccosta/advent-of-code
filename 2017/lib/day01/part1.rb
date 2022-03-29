module DayOne
  class PartOne
    def self.solve(input)
      input << input[0]
      sum = 0

      input.chars.map(&:to_i).each_cons(2) do |c, n|
        sum += c if c == n
      end

      sum
    end
  end
end
