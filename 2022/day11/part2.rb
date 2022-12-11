input = File
  .read("input.txt")
  .split("\n\n")
  .map { |attrs|
    attrs.split("\n").map { |l|
      l.split(": ").last.strip
    }
  }

ROUNDS = 10_000

class Monkey
  attr_reader :modulo, :inspect_count

  def initialize(items_str, op_str, mod_str, if_true_str, if_false_str)
    @items = items_str.split.map(&:to_i)
    @op =
      case op_str.split(" = ")[1].split
      in ["old", "*", "old"]
        ->(x) { x * x }
      in ["old", "*", v]
        ->(x) { x * v.to_i }
      in ["old", "+", v]
        ->(x) { x + v.to_i }
      end

    @modulo = mod_str.split.last.to_i
    @if_true = if_true_str.split.last.to_i
    @if_false = if_false_str.split.last.to_i

    @inspect_count = 0
  end

  def inspect(&block)
    until @items.empty?
      worry = @op[@items.shift]

      if worry % @modulo == 0
        block.call(worry, @if_true)
      else
        block.call(worry, @if_false)
      end

      @inspect_count += 1
    end
  end

  def receive(item)
    @items.push(item)
  end
end

monkeys = input.map { Monkey.new(*_1[1..]) }
mod = monkeys.map(&:modulo).inject(:*)

ROUNDS.times do
  monkeys.each do |monkey|
    monkey.inspect do |worry, target|
      monkeys[target].receive(worry % mod)
    end
  end
end

p monkeys.map(&:inspect_count).max(2).inject(:*)
