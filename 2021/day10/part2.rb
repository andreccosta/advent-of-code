LINES = File.readlines('input.txt', chomp: true)

MAPPING = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>'
}.freeze

POINTS = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}.freeze

def points(line)
  queue = []

  line.chars.each do |c|
    if MAPPING.keys.include?(c)
      queue.push(MAPPING[c])
    elsif c != queue.pop
      return false
    end
  end

  queue.reverse.inject(0) { |points, char| points * 5 + POINTS[char] }
end

scores = LINES.filter_map { |l| points(l) }

p scores.sort[scores.length / 2]
