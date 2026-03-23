# Given an array of integers nums and an integer target,
# return indices of the two numbers such that they add up to target.

# You may assume that each input would have exactly one solution,
# and you may not use the same element twice.

# You can return the answer in any order.

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
  seen = {}
  nums.each_with_index do |x, i|
    return [seen[target - x], i] unless seen[target - x].nil?
    seen[x] = i # only add after checking to handle target - x == x case
  end
  []
end

require_relative './testing'
Testing.expect(two_sum([2,7,11,15], 9), [0, 1])
Testing.expect(two_sum([3,2,4], 6), [1, 2])
Testing.expect(two_sum([3, 3], 6), [0, 1])
Testing.expect(two_sum([3], 6), [])
Testing.expect(two_sum([-3, 3], 0), [0, 1])
Testing.expect(two_sum([0], 0), [])
Testing.expect(two_sum([3, 0], 3), [0, 1])
Testing.summary
