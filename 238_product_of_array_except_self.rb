# Given an integer array nums, return an array answer such that answer[i] is equal
# to the product of all the elements of nums except nums[i].

# The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.

# You must write an algorithm that runs in O(n) time and without using the division operation.

# @param {Integer[]} nums
# @return {Integer[]}
def product_except_self_1(nums)
  prefixes = []
  suffixes = []

  nums.length.times do |i|
    prefixes << (prefixes.last || 1) * nums[i]
    suffixes << (suffixes.last || 1) * nums[nums.length - 1 - i]
  end

  nums.length.times.map do |i|
    prefix = i - 1 >= 0 ? prefixes[i - 1] : 1
    suffix = nums.length - 2 - i >= 0 ? suffixes[nums.length - 2 - i] : 1
    prefix * suffix
  end
end

# Follow up: Can you solve the problem in O(1) extra space complexity?
# (The output array does not count as extra space for space complexity analysis.)
def product_except_self(nums)
  output = Array.new(nums.length)

  output[0] = 1
  (1...nums.length).each do |i|
    output[i] = output[i - 1] * nums[i - 1]
  end

  suffix = 1
  nums.length.times.map do |i|
    output[nums.length - 1 - i] *= suffix
    suffix *= nums[nums.length - 1 - i]
  end

  output
end

require_relative './testing'
Testing.expect(product_except_self([1, 2, 3, 4]), [24, 12, 8, 6])
Testing.expect(product_except_self([-1, 1, 0, -3, 3]), [0, 0, 9, 0, 0])
Testing.expect(product_except_self([3, 2]), [2, 3])
Testing.expect(product_except_self([-1, 1, 1000]), [1000, -1000, -1])
Testing.summary
