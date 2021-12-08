lines = File.readlines('input.txt', chomp: true)

entries = lines.map do |l|
  parts = l.split(' | ')
  { signals: parts.first.split, outputs: parts.last.split }
end

def decode(str, segments)
  case str.length
  when 2
    1
  when 3
    7
  when 4
    4
  when 5
    if segments.has_key?(7) && (segments[7] - str.chars).empty?
      3
    elsif segments.has_key?(6) && (segments[6] - str.chars).length == 1
      5
    elsif segments.has_key?(6)
      2
    end
  when 6
    if segments.has_key?(1) && !(segments[1] - str.chars).empty?
      6
    elsif segments.has_key?(4) && (segments[4] - str.chars).empty?
      9
    elsif segments.has_key?(4)
      0
    end
  when 7
    8
  end
end

results = []

entries.each do |e|
  segments = {}
  signals = e[:signals]
  outputs = e[:outputs]

  while segments.length < 10
    signals.each do |s|
      digit = decode(s, segments)
      segments[digit] = s.chars if digit
    end
  end

  result = []
  outputs.each_with_index do |o, i|
    result << segments.find { |k, v| o.chars.sort == v.sort }.first
  end
  results << result.join.to_i
end

p results.sum
