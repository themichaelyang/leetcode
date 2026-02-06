# https://leetcode.com/problems/unique-paths/

# There is a robot on an m x n grid. The robot is initially located at the top-left corner (i.e., grid[0][0]). The robot tries to move to the bottom-right corner (i.e., grid[m - 1][n - 1]). The robot can only move either down or right at any point in time.
# Given the two integers m and n, return the number of possible unique paths that the robot can take to reach the bottom-right corner.

# The test cases are generated so that the answer will be less than or equal to 2 * 109.

# There may be a closed form solution but not sure how to figure it out.
# 1 1  1  1  1
# 1 2  3  4  5
# 1 3  6 10 15
# 1 4 10 20 35
# 1 5 15 35 70

# Hmm, this can be thought of as a counting problem.
# For a 1d grid of width n, there are n - 1 steps in between the n tiles.
# For a 2d grid of height m, width n, there are (m - 1) + (n - 1) steps to get to the corner. 
# m - 1 vertical steps and n - 1 horizontal steps. 
# AKA m + n - 2.
# So, any path is m + n - 2 long. You must pick n - 1 places to go right, m - 1 places to go down.
# This is equivalent to total steps choose right steps: m + n - 2 choose n - 1

# It doesn't matter if you choose n - 1 or choose m - 1, since the answer is the same. The other steps are fixed by your choice of downs or rights with the other step.

# If you want to think of this formulaically, the other choices are
# ((m - 1) + (n - 1) - (n - 1)) choose (m - 1) = 1.

def unique_paths(m, n)
  down_steps = m - 1
  right_steps = n - 1
  steps = down_steps + right_steps

  n_choose_k(steps, down_steps)
end

def n_choose_k(n, k)
  fact(n, n - k + 1) / fact(k)
end

def fact(high, low=1)
  (low..high).reduce(&:*) || 1
end

# Could trivially convert to O(n) space by only keeping the previous row
# Ishaan notes: You could write in place and pick whether loop through rows
# or columns to get O(min(n, m)) space.
# def unique_paths(m, n)
#   grid = Array.new(m)

#   m.times.with_index do |y|
#     grid[y] = Array.new(n)
#     grid[y][0] = 1

#     n.times.with_index do |x|
#       from_left = if x - 1 >= 0 then grid[y][x - 1] else 0 end
#       from_above = if y - 1 >= 0 then grid[y - 1][x] else 0 end

#       grid[y][x] ||= from_left + from_above
#     end
#   end

#   grid.last.last
# end

require_relative "../test"

class Test
  extend TestSuite
  assert_equals(unique_paths(3, 7), 28)
end