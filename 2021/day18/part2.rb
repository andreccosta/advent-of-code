lines = File.readlines('input.txt', chomp: true)
numbers = lines.map { |l| eval l }

def reduce(arr)
  changed = true

  while changed
    arr, changed = explode(arr)
    arr, changed = split(arr) unless changed
  end

  arr
end

def split(el, done = false)
  arr = el.map do |e|
    if e.is_a?(Array)
      new_arr, done = split(e, done)
      new_arr
    elsif e >= 10 && !done
      done = true
      [(e / 2.0).floor, (e / 2.0).ceil]
    else
      e
    end
  end

  [arr, done]
end

def explode(arr)
  arr, _, _, _, done = explode_recur(arr)

  [arr, done]
end

def explode_recur(el, depth = 0, lrn_arr = nil, lrn_arr_idx = nil, right = nil, done = false)
  new_arr = []
  depth += 1

  el.each_with_index do |e, i|
    if e.is_a?(Array)
      if depth >= 4 && !done
        done = true

        left = e.first
        right = e.last

        # set left if any
        lrn_arr[lrn_arr_idx] += left if lrn_arr && lrn_arr_idx

        new_arr << 0
      else
        arr, lrn_arr, lrn_arr_idx, right, done = explode_recur(e, depth, lrn_arr, lrn_arr_idx, right, done)
        new_arr << arr
      end
    else
      new_arr << e + (right || 0)
      right = nil

      lrn_arr = new_arr
      lrn_arr_idx = new_arr.length - 1
    end
  end

  [new_arr, lrn_arr, lrn_arr_idx, right, done]
end

def add(arr1, arr2)
  [arr1, arr2]
end

def magnitude(arr)
  return arr unless arr.is_a?(Array)

  3 * magnitude(arr.first) + 2 * magnitude(arr.last)
end

p numbers
  .permutation(2)
  .map { |a, b| magnitude(reduce(add(a, b))) }
  .max
