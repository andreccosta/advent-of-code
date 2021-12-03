lines = File.readlines('input.txt', chomp: true)
  .map(&:chars)

gamma_rate = ""
epsilon_rate = ""

cols = lines.transpose

(0..cols.length - 1).each do |i|
  least, most = *cols[i].tally.sort_by(&:last).to_h.keys

  gamma_rate << most
  epsilon_rate << least
end

p gamma_rate.to_i(2) * epsilon_rate.to_i(2)