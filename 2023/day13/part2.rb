lines = File.readlines("input.txt", chomp: true)
patterns = lines.slice_before("").map { _1.reject(&:empty?) }

def diff(a, b)
  a.chars.zip(b.chars).count { _1 != _2 }
end

def reflection_rows(lines)
  cleaned_smudge = false

  lines.each_cons(2).with_index do |(a, b), i|
    if a == b || diff(a, b) == 1
      cleaned_smudge = diff(a, b) == 1

      return i + 1 if valid_mirror?(lines, i, cleaned_smudge)
    end
  end

  0
end

def reflection_cols(lines)
  reflection_rows(lines.map(&:chars).transpose.map(&:join))
end

def valid_mirror?(arr, index, cleaned_smudge)
  top = arr[0..index]
  bottom = arr[index + 1..-1]

  ti = index - 1
  bi = 1

  while ti >= 0
    return cleaned_smudge if bi >= bottom.size

    if top[ti] != bottom[bi]
      return false if diff(top[ti], bottom[bi]) > 1
      return false if cleaned_smudge

      cleaned_smudge = true
    end

    ti -= 1
    bi += 1
  end

  cleaned_smudge
end

cols = patterns.map(&method(:reflection_cols)).sum
rows = patterns.map(&method(:reflection_rows)).sum

p cols + 100 * rows
