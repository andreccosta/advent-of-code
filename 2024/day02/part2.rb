lines = File.readlines("input.txt", chomp: true)
reports = lines.map { |l| l.split.map(&:to_i) }

def safe?(report)
  trend = nil

  report.each_cons(2).all? do |a, b|
    case b - a
    when 1..3
      trend ||= :up
      trend == :up
    when -3..-1
      trend ||= :down
      trend == :down
    else
      false
    end
  end
end

t = reports.count do |report|
  next true if safe?(report)

  report.each_index.any? { |i|
    safe?(report.reject.with_index { |_, index| index == i })
  }
end

puts t
