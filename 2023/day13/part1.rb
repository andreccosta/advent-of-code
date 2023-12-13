lines = File.readlines("input.txt", chomp: true)
patterns = lines.slice_before("").map { _1.reject(&:empty?) }

def reflection_rows(lines)
  lines.each_cons(2).with_index do |(a, b), i|
    return i + 1 if a == b && valid?(lines, i)
  end

  0
end

def reflection_cols(lines)
  reflection_rows(lines.map(&:chars).transpose.map(&:join))
end

def valid?(arr, index)
  top = arr[0..index]
  bottom = arr[index + 1..-1]

  ti = index - 1
  bi = 1

  while ti >= 0
    return true if bi >= bottom.size
    return false unless top[ti] == bottom[bi]

    ti -= 1
    bi += 1
  end

  true
end

cols = patterns.map(&method(:reflection_cols)).sum
rows = patterns.map(&method(:reflection_rows)).sum

p cols + 100 * rows
