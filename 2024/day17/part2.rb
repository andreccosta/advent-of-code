class Computer
  attr_reader :a, :b, :c, :output

  def initialize(a, b, c)
    @a, @b, @c, @output = a, b, c, []
  end

  def instruction(i)
    {
      0 => :adv,
      1 => :bxl,
      2 => :bst,
      3 => :jnz,
      4 => :bxc,
      5 => :out,
      6 => :bdv,
      7 => :cdv
    }[i]
  end

  def operand(o)
    case o
    when (0..3)
      o
    when 4
      a
    when 5
      b
    when 6
      c
    end
  end

  def adv(arg)
    @a = a / (2 ** operand(arg))
  end

  def bdv(arg)
    @b = a / (2 ** operand(arg))
  end

  def cdv(arg)
    @c = a / (2 ** operand(arg))
  end

  def bxl(arg)
    @b = b ^ arg
  end

  def bxc(_arg)
    @b = b ^ c
  end

  def bst(arg)
    @b = operand(arg) % 8
  end

  def out(arg)
    @output << operand(arg) % 8
  end

  def clear
    @output = []
  end

  def set_a(v)
    @a = v
  end
end

registers, program = File.read("input.txt").split("\n\n")
registers = registers.split("\n").map { _1[/\d+/].to_i }
program = program.split(" ").last.split(",").map(&:to_i)

c = Computer.new(*registers)

def run(c, program)
  i = 0
  max_i = program.length

  while i < max_i
    instr = c.instruction(program[i])

    if instr == :jnz
      break if c.a.nil? || c.a == 0
      i = program[i+1]
    else
      c.send(instr, program[i+1])
      i += 2
    end
  end

  c.output
end

i = program.length - 1
prefixes = ['']

until i < 0
  valid = []

  (0...8).each do |digit|
    prefixes.each do |prefix|
      str = "#{prefix}#{digit}"

      c.set_a(str.to_i(8))
      c.clear

      result = run(c, program)
      valid << str if result == program[i..]
    end
  end

  i -= 1
  prefixes = valid
end

p prefixes.map { |p| p.to_i(8) }.min
