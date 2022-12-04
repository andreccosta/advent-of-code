lines = File.readlines("input.txt", chomp: true)

p lines.count { |line|
  fs, fe, ss, se = line
    .split(",")
    .flat_map { |p|
      p.split("-").map(&:to_i)
    }

  fs <= ss && ss <= fe || ss <= fs && fs <= se
}
