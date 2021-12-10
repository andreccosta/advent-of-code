LINES = File.readlines('input.txt', chomp: true)

MAPPING = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>'
}.freeze

POINTS = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25_137
}.freeze

def points(line)
  queue = []

  line.chars.each do |c|
    if MAPPING.keys.include?(c)
      queue.push(MAPPING[c])
    elsif c != queue.pop
      return POINTS[c]
    end
  end

  0
end

p LINES.sum { |l| points(l) }
