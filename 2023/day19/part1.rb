input = File.read("input.txt", chomp: true)

workflows, parts_ratings = input.split("\n\n").map { |x| x.split("\n") }

workflows = workflows.map do |workflow|
  name, rules = workflow.delete("}").split("{")
  [name, rules.split(",")]
end.to_h

parts = parts_ratings.map do |ratings|
  ratings.delete("{}").split(",").map {
    n, v = _1.split("=")
    [n, v.to_i]
  }.to_h
end

r = parts.sum do |part|
  bind = binding.tap { |b| part.each { |n, v| b.local_variable_set(n, v) } }
  wf = "in"

  while wf != "A" && wf != "R"
    rules = workflows[wf]

    wf = rules.each do |rule|
      condition, result = rule.split(":")

      break condition unless result
      break result if bind.eval(condition)
    end
  end

  (wf == "A") ? part.values.sum : 0
end

p r
