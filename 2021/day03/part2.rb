lines = File.readlines('input.txt', chomp: true)
  .map(&:chars)

def calculate_rating(lines, lc = false)
  lines_left = lines

  (0..lines[0].length - 1).each do |i|
    col = lines_left.transpose[i]

    if col.count('0') > col.count('1')
      char = lc ? '1' : '0'
    else
      char = lc ? '0' : '1'
    end

    lines_left = col
      .filter_map.with_index { |c, idx| lines_left[idx] if c == char }

    return lines_left.join.to_i(2) if lines_left.length == 1
  end
end

oxygen_rating = calculate_rating(lines)
epsilon_rating = calculate_rating(lines, true)

p oxygen_rating * epsilon_rating
