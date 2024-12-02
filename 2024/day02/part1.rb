lines = File.readlines("input.txt", chomp: true)
reports = lines.map { |l| l.split.map(&:to_i) }

t = reports.count do |report|
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

puts t
