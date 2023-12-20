class BaseModule
  attr_accessor :id, :destinations

  def initialize(id, destinations)
    @id = id
    @destinations = destinations
  end

  def process(input, signal)
  end
end

class BroadcasterModule < BaseModule
  def process(input, signal)
    destinations.map { |d| [id, d, signal] }
  end
end

class FlipFlopModule < BaseModule
  attr_accessor :state

  def initialize(id, destinations)
    super(id, destinations)
    @state = 0
  end

  def process(input, signal)
    return unless signal == 0

    @state = 1 - state
    destinations.map { |d| [id, d, state] }
  end
end

class ConjunctionModule < BaseModule
  attr_accessor :inputs

  def initialize(id, destinations)
    super(id, destinations)
    @inputs = {}
  end

  def process(input, signal)
    @inputs[input] = signal

    if inputs.values.all? { _1 == 1 }
      destinations.map { |d| [id, d, 0] }
    else
      destinations.map { |d| [id, d, 1] }
    end
  end
end

lines = File.readlines("input.txt", chomp: true)
modules = {}

lines.each do |line|
  spec, dest = line.split(" -> ")
  type, id = [spec[0], spec[1..]]

  m = case type
  when "b"
    BroadcasterModule.new("broadcaster", dest.split(", "))
  when "%"
    FlipFlopModule.new(id, dest.split(", "))
  when "&"
    ConjunctionModule.new(id, dest.split(", "))
  else
    raise
  end

  modules[m.id] = m
end

# fill in inputs
modules.values.filter { |m| m.is_a?(ConjunctionModule) }.each do |m|
  m.inputs = modules.filter { |k, v| v.destinations.include?(m.id) }.map { |k, v| [k, 0] }.to_h
end

# find source for rx
rx_source = modules.find { |k, v| v.destinations.include?("rx") }.first

# and the sources for that
sources = []
modules.values.each do |m|
  sources << m.id if m.destinations.include?(rx_source)
end

mdl = "broadcaster"
presses = 0
conj = {}

loop do
  presses += 1

  queue = Queue.new
  queue << ["button", "broadcaster", 0]

  until queue.empty?
    source, dest, signal = queue.pop

    if signal == 0 && sources.include?(dest)
      conj[dest] = presses
    end

    if conj.size == 4
      p conj.values.inject(:lcm)
      return
    end

    mdl = modules[dest]
    next unless mdl

    process_result = mdl.process(source, signal)
    process_result&.each { queue << _1 }
  end
end
