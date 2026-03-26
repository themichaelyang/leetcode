# Given an array nums containing n distinct numbers in the range [0, n],
# return the only number in the range that is missing from the array.

# Follow up: Could you implement a solution using only O(1) extra space complexity and O(n) runtime complexity?

# @param {Integer[]} nums
# @return {Integer}
def missing_number(nums)
  nums.reduce(&:^) ^ 0.upto(nums.length).reduce(&:^)
end

require_relative './testing'
Testing.expect(missing_number([3,0,1]), 2)
Testing.expect(missing_number([0,1]), 2)
Testing.expect(missing_number([9,6,4,2,3,5,7,0,1]), 8)
Testing.expect(missing_number([0, 1, 5, 4, 2]), 3)
Testing.summary
