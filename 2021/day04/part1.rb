lines = File.readlines('input.txt', chomp: true)

draw = lines[0].split(',').map(&:to_i)
boards = []
board = []

lines[2..lines.length - 1].each do |l|
  if l.empty?
    boards << board if board.any?
    board = []
  else
    board << l.split.map { |i| { n: i.to_i, marked: false } }
  end
end
boards << board if board.any?

def mark(boards, n)
  boards.each do |board|
    board.each { |r| r.map { |e| e[:n] == n ? e[:marked] = true : e } }
  end
end

def winner?(board)
  board.any? { |r| r.all? { |e| e[:marked] } } ||
    board.transpose.any? { |c| c.all? { |e| e[:marked] } }
end

win_board = nil
last = nil

draw.each do |d|
  mark(boards, d)

  if boards.any? { |b| winner?(b) }
    win_board = boards.find { |b| winner?(b) }
    last = d
    break
  end
end

win_board_sum = win_board.map { |r|
  r.filter_map { |e| !e[:marked] && e[:n] }.sum
}.sum

p win_board_sum * last
