require 'matrix'

data = File.read("input.txt")
machines = data.split("\n\n").map { _1.split("\n")}

def parse_button(button)
  Vector[
    button[/X\+(\d+)/, 1]&.to_i,
    button[/Y\+(\d+)/, 1]&.to_i
  ]
end

def parse_prize(prize)
  Vector[
    prize[/X\=(\d+)/, 1]&.to_i,
    prize[/Y\=(\d+)/, 1]&.to_i
  ]
end

def parse(machine)
  button_a, button_b, prize = machine

  [
    parse_button(button_a),
    parse_button(button_b),
    parse_prize(prize)
  ]
end

tokens = machines.sum do |machine|
  button_a, button_b, prize = parse(machine)

  m = Matrix.columns([button_a, button_b])

  if m.regular?
    w = m.inverse * prize
    wa, wb = w[0], w[1]

    if wa.denominator == 1 && wb.denominator == 1
      next 3 * wa.to_i + 1 * wb.to_i
    end
  end

  0
end

p tokens
