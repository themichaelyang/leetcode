# You are given an integer array nums consisting of n elements, and an integer k.

# Find a contiguous subarray whose length is equal to k that has the maximum
# average value and return this value.

# Any answer with a calculation error less than 10-5 will be accepted.
  
# @param {Integer[]} nums
# @param {Integer} k
# @return {Float}
def find_max_average(nums, k)
  window_sum = nums[0...k].sum
  
  (k...nums.length).reduce(window_sum) do |max_sum, i|
    window_sum += nums[i]
    window_sum -= nums[i - k]

    [max_sum, window_sum].max
  end / k.to_f
end

require_relative 'testing'
Testing.expect(find_max_average([1, 12, -5, -6, 50, 3], 4), 12.75)
Testing.expect(find_max_average([5], 1), 5)
Testing.expect(find_max_average([1, 2, 3, 4, 5, 6, 7, 8], 2), 7.5)
Testing.summary
