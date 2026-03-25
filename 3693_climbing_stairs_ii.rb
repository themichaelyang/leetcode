# You are climbing a staircase with n + 1 steps, numbered from 0 to n.

# You are also given a 1-indexed integer array costs of length n,
# where costs[i] is the cost of step i.

# From step i, you can jump only to step i + 1, i + 2, or i + 3.
# The cost of jumping from step i to step j is defined as:
# costs[j] + (j - i)^2

# You start from step 0 with cost = 0.

# Return the minimum total cost to reach step n.

# for some reason cost in problem is specified with 1-index?
def jump_cost(i, j, costs)
  return Float::INFINITY if i < 0
  costs[j - 1] + (j - i) ** 2
end

# @param {Integer} n
# @param {Integer[]} costs
# @return {Integer}
def climb_stairs(n, costs)
  ways = Array.new(n + 1)
  ways[0] = 0

  1.upto(n) do |i|
    ways[i] = [
      ways[i - 1]&.+(jump_cost(i - 1, i, costs)),
      ways[i - 2]&.+(jump_cost(i - 2, i, costs)),
      ways[i - 3]&.+(jump_cost(i - 3, i, costs))
    ].compact.min
  end

  ways[n]
end

require_relative './testing'
Testing.expect(climb_stairs(4, [1, 2, 3, 4]), 13)
Testing.expect(climb_stairs(4, [5, 1, 6, 2]), 11)
Testing.expect(climb_stairs(3, [9, 8, 3]), 12)
Testing.expect(climb_stairs(1, [1]), 2)
Testing.summary
