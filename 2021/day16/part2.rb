message = File.read("input.txt")

MAX_PACKET_SIZE = 500

class Packet
  attr_reader :length, :type_id, :value, :version

  def initialize(raw_input)
    @raw_input = raw_input
    @sub_packets = []

    @length = 6
    @binary = raw_input.slice(0, 6)

    # parse header
    @version = @binary.slice(0, 3).to_i(2)
    @type_id = @binary.slice(3, 3).to_i(2)

    if @type_id == 4
      @value = groups.join.to_i(2)
    else
      @binary << raw_input[6]
      @length_type_id = raw_input[6].to_i
      @length += 1

      parse_sub_packets

      case @type_id
      when 0
        #sum
        @value = @sub_packets.map(&:value).sum
      when 1
        #product
        @value =  @sub_packets.map(&:value).reduce(:*)
      when 2
        #min
        @value = @sub_packets.map(&:value).min
      when 3
        #max
        @value = @sub_packets.map(&:value).max
      when 5
        #greater than
        @value = @sub_packets.first.value > @sub_packets.last.value ? 1 : 0
      when 6
        #less than
        @value = @sub_packets.first.value < @sub_packets.last.value ? 1 : 0
      when 7
        #equal
        @value = @sub_packets[0].value == @sub_packets.last.value ? 1 : 0
      end
    end
  end

  def parse_sub_packets
    if @length_type_id == 0
      @binary << @raw_input.slice(7, 15)
      total_length = @binary.slice(7, 15).to_i(2)
      @length += 15
      start = 22

      while @sub_packets.sum(&:length) < total_length
        start_now = start + @sub_packets.sum(&:length)
        @sub_packets << Packet.new(@raw_input.slice(start_now, MAX_PACKET_SIZE))
      end
    else
      @binary << @raw_input.slice(7, 11)
      number_of_packets = @binary.slice(7, 11).to_i(2)
      @length += 11

      start = 18

      while @sub_packets.length < number_of_packets
        start_now = start + @sub_packets.sum(&:length)
        @sub_packets << Packet.new(@raw_input.slice(start_now, MAX_PACKET_SIZE))
      end
    end

    @length += @sub_packets.sum(&:length)
  end

  def groups
    groups = []
    index = 6

    while true
      group = @raw_input[index..index + 4]
      @binary << group
      groups << group[1..4]

      break if group[0] == "0"

      index += 5
    end

    @length += groups.size * 5

    groups
  end

  def version_sum
    @version + @sub_packets.sum(&:version_sum)
  end
end

def hex_to_binary_str(str)
  str.chars
    .map { |c| c.to_i(16).to_s(2).rjust(4, "0") }
    .join
end

def decode(message)
  binary = hex_to_binary_str(message)
  packets = []
  start = 0

  while start < binary.length
    remaining = binary[start..]

    break if remaining.count("0") == remaining.length

    packet = Packet.new(remaining)
    start += packet.length
    packets << packet
  end

  packets
end

packets = decode(message)

p packets.sum(&:value)
