input = File.read("input.txt", chomp: true)

workflows, _ = input.split("\n\n").map { |x| x.split("\n") }

def run(code, workflows, ranges)
  instructions = workflows[code]

  instructions.sum do |instruction|
    used, left, wf = instruction.call(ranges)

    if wf == "A" || wf == "R"
      total = used.values.map(&:size).reduce(&:*) if wf == "A"
    else
      total = run(wf, workflows, used)
    end

    ranges = left
    total || 0
  end
end

workflows = workflows.map do |workflow|
  name, rules = workflow.delete("}").split("{")
  conditions = rules.split(",")

  conditions.map! do |condition|
    check, dest = condition.split(":")

    if dest.nil?
      ->(ranges) { [ranges, nil, check] }
    else
      to_check, arg = check.split(/[<>]/)
      arg = arg.to_i

      ->(ranges) do
        used = ranges.dup
        left = ranges.dup

        ru = used[to_check]
        rl = left[to_check]

        if check.include?("<")
          used[to_check] = (ru.min...arg)
          left[to_check] = (arg..rl.max)
        else
          used[to_check] = (arg + 1..ru.max)
          left[to_check] = (rl.min..arg)
        end

        [used, left, dest]
      end
    end
  end

  [name, conditions]
end.to_h

ranges = "xmas".chars.map { |c| [c, (1..4000)] }.to_h

p run("in", workflows, ranges)
