def min_distance(start, target)
  # Make memory a bit larger to keep the elegant ||= logic
  memory = Array.new(start.length + 1)
  memory.size.times do |sc|
    memory[sc] = Array.new(target.length + 1)
  end

  if target.empty? or start.empty?
    [start.length, target.length].max
  else
    substrings_min_distance(start, target, 0, 0, memory)
  end
end

def substrings_min_distance(start, target, sc, tc, memory)
  memory[sc][tc] ||= if sc == start.length and tc == target.length
    0
  else
    possible_edits = []

    # Remove start[sc]
    if sc < start.length
      possible_edits << substrings_min_distance(start, target, sc + 1, tc, memory) + 1
    end

    # Insert target[tc] at sc
    if tc < target.length
      possible_edits << substrings_min_distance(start, target, sc, tc + 1, memory) + 1
    end

    if sc < start.length and tc < target.length
      possible_edits << if start[sc] == target[tc]
        # Keep matched start[sc] with target[tc]
        substrings_min_distance(start, target, sc + 1, tc + 1, memory)
      else
        # Replace start[sc] with target[tc]
        substrings_min_distance(start, target, sc + 1, tc + 1, memory) + 1
      end
    end

    possible_edits.min
  end
end


require_relative '../test'
extend TestSuite

assert_equals(min_distance('horse', 'ros'), 3)
assert_equals(min_distance('intention', 'execution'), 5)
assert_equals(min_distance('abc', 'abc'), 0)
assert_equals(min_distance('abc', 'ab'), 1)
assert_equals(min_distance('abc', ''), 3)
assert_equals(min_distance('', ''), 0)
assert_equals(min_distance('', 'a'), 1)
assert_equals(min_distance('ab', 'abc'), 1)
assert_equals(min_distance('sea', 'ate'), 3)