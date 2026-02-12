# You are given an integer array nums and an integer k.

# In one operation, you can pick two numbers from the array whose sum equals k and remove them from the array.

# Return the maximum number of operations you can perform on the array.

# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer}
def max_operations(nums, k)
  tally = nums.tally
  tally.sum do |x, cnt|
    if x == k - x
      ops = tally[x] / 2
      tally[x] = tally[x] % 2
      ops
    elsif tally[k - x]
      ops = [tally[k - x], cnt].min
      tally[x] -= ops
      tally[k - x] -= ops
      ops
    else
      0
    end
  end
end

require_relative 'testing'

Testing.expect(max_operations([1, 2, 3, 4], 5), 2)
Testing.expect(max_operations([3, 1, 3, 4, 3], 6), 1)
Testing.expect(max_operations([2], 4), 0)
Testing.expect(max_operations([2, 2, 2, 2, 2], 4), 2)
Testing.expect(max_operations([1, 2, 3, 4, 5, 6], 7), 3)

Testing.summary
