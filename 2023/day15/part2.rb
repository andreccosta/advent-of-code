input = File.read("input.txt", chomp: true)

boxes = (0..255).map { {} }

def hsh(str)
  str.each_char.inject(0) do |cv, c|
    (cv + c.ord) * 17 % 256
  end
end

def power(boxes)
  boxes.each_with_index.sum do |box, i|
    box.each_with_index.sum do |(label, focal_length), j|
      (i + 1) * (j + 1) * focal_length.to_i
    end
  end
end

input.split(",").each do |l|
  if l.include?("=")
    label, focal_length = l.split("=")

    box = boxes[hsh(label)]
    box[label] = focal_length
  else
    label, _ = l.split("-")

    box = boxes[hsh(label)]
    box.delete(label)
  end
end

p power(boxes)
