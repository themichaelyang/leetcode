# Given an array of integers nums and an integer target,
# return indices of the two numbers such that they add up to target.

# You may assume that each input would have exactly one solution,
# and you may not use the same element twice.

# You can return the answer in any order.

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
  indexes = {}

  nums.each_with_index do |x, i|
    indexes[x] ||= []
    indexes[x].append(i)
  end

  nums.each_with_index do |x, i|
    next if indexes[target - x].nil?
    return [i, indexes[target - x][0]] unless target - x == x
    return [i, indexes[x][1]] if target - x == x && indexes[target - x].length >= 2
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
