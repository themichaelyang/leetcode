def min_distance(start, target)
  # Make memory a bit larger to keep the elegant ||= logic
  memory = Array.new(start.length + 1)
  memory.size.times do |sc|
    memory[sc] = Array.new(target.length + 1)
  end

  substrings_min_distance(start, target, 0, 0, memory)
end

# memory[sc][tc] represents the min edit distance of start[0..sc] -> target[0..tc]
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

# we start at 0 index of start and 0 index of target, and slowly build target from start.
# once we've built up the entire target string and used up all of start, we've 
# finished edits.
#
# at each position sc in start string, you can either...
# 1. replace start[sc] with target[tc]. this means:
#    a) tc + 1: we matched start[sc] to target[tc], now we move onto matching target[tc + 1]
#    b) sc + 1: we edited start[sc], now we move onto using start[sc + 1]
#    b) edits + 1: replacing is an edit
# 2. remove start[sc]. this means: 
#    a) tc + 0: we didn't match target[tc] or chose not to match with start[sc]
#    b) sc + 1: we edited start[sc], now we move onto using start[sc + 1]
#    c) edits + 1: removing is an edit
# 3. insert target[tc] before start[sc]. this means:
#    a) tc + 1: we matched target[tc], now we move onto matching target[tc + 1]
#    b) sc + 0: we inserted a match to target[tc] before start[sc] so we didn't use start[sc]
#    c) edits + 1: inserting is an edit
# 5. if start[sc] == target[tc], consider that a match and move on. this means:
#    a) tc + 1: we matched target[tc]
#    b) sc + 1: we used start[sc]
#    c) edits + 0: we didn't use any edits because it already matched!
#       note that this is always better than replacing.

# O(start.length * target.length)

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