# You are climbing a staircase. It takes n steps to reach the top.

# Each time you can either climb 1 or 2 steps.
# In how many distinct ways can you climb to the top?

# @param {Integer} n
# @return {Integer}
# iterative
# def climb_stairs(n)
#   ways = Array.new(n + 1)
#   ways[0] = 0
#   ways[1] = 1
#   ways[2] = 2

#   3.upto(n) do |i|
#     ways[i] = ways[i - 2] + ways[i - 1]
#   end

#   ways[n]
# end

# recursive
def climb_stairs(n, cache={})
  return n if n <= 2
  cache[n] ||= climb_stairs(n - 1, cache) + climb_stairs(n - 2, cache)
end

require_relative './testing'
Testing.expect(climb_stairs(2), 2)
Testing.expect(climb_stairs(3), 3)
Testing.expect(climb_stairs(4), 5)
Testing.expect(climb_stairs(5), 8)
Testing.summary
