lines = File.read("input.txt")

rules, pages = lines.split("\n\n").map { |group| group.split("\n") }
rules = rules.map { |r| r.split("|").map(&:to_i) }

def is_valid?(rules, values)
  rules.each do |a, b|
    if values.include?(a) && values.include?(b)
      return false if values.index(a) > values.index(b)
    end
  end

  true
end

r = pages.sum do |page|
  page_values = page.split(",").map(&:to_i)

  next 0 if is_valid?(rules, page_values)

  until is_valid?(rules, page_values)
    rules.each do |a, b|
      if page_values.include?(a) && page_values.include?(b)
        a_index = page_values.index(a)
        b_index = page_values.index(b)

        if a_index > b_index
          page_values[a_index], page_values[b_index] = page_values[b_index], page_values[a_index]
        end
      end
    end
  end

  page_values[page_values.length / 2]
end

p r
