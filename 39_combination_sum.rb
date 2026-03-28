# Given an array of distinct integers candidates and a target integer target,
# return a list of all unique combinations of candidates where the chosen numbers sum to target.
# You may return the combinations in any order.

# The same number may be chosen from candidates an unlimited number of times.
# Two combinations are unique if the frequency of at least one of the chosen
# numbers is different.

# The test cases are generated such that the number of unique combinations that
# sum up to target is less than 150 combinations for the given input.

# Constraints:
#   1 <= candidates.length <= 30
#   2 <= candidates[i] <= 40
#   All elements of candidates are distinct.
#   1 <= target <= 40

# @param {Integer[]} candidates
# @param {Integer} target
# @return {Integer[][]}
# neetcode solution just has two recursive cases:
# taking a number (don't advance index) or skipping it (index + 1)
#
# the constraints help a lot, since they are distinct and you can use each
# number any number of times
def combination_sum(candidates, target, start=0, sum=0, path=[])
  return [path] if target == sum
  return [] if start >= candidates.length
  return [] if sum > target
  return [] if path.length >= 150

  start.upto(candidates.length - 1).each.flat_map do |i|
    x = candidates[i]
    combination_sum(candidates, target, i, sum + x, path + [x])
  end
end

require_relative './testing'
Testing.expect(combination_sum([2,3,6,7], 7), [[2,2,3],[7]])
Testing.expect(combination_sum([2,3,5], 8), [[2,2,2,2],[2,3,3],[3,5]])
Testing.summary
