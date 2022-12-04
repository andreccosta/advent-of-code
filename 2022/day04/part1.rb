lines = File.readlines("input.txt", chomp: true)

p lines.count { |line|
  fs, fe, ss, se = line
    .split(",")
    .flat_map { |p|
      p.split("-").map(&:to_i)
    }

  fs <= ss && se <= fe || ss <= fs && fe <= se
}
