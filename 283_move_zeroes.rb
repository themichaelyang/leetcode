# Given an integer array nums, move all 0's to the end of it while maintaining
# the relative order of the non-zero elements.

# Note that you must do this in-place without making a copy of the array.

# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def move_zeroes(nums)
  zeroes = 0
  next_index = 0

  nums.each do |x|
    if x.zero?
      zeroes += 1
    else
      nums[next_index] = x
      next_index += 1
    end
  end

  nums[-zeroes..-1] = [0] * zeroes if zeroes > 0

  nums
end

require_relative './testing'

Testing.expect(move_zeroes([1]), [1])
Testing.expect(move_zeroes([0]), [0])
Testing.expect(move_zeroes([1, 0]), [1, 0])
Testing.expect(move_zeroes([0, 1]), [1, 0])
Testing.expect(move_zeroes([0, 1, 2]), [1, 2, 0])
Testing.expect(move_zeroes([1, 0, 2]), [1, 2, 0])
Testing.expect(move_zeroes([1, 2, 0]), [1, 2, 0])
Testing.expect(move_zeroes([0, 1, 0, 2, 0]), [1, 2, 0, 0, 0])
Testing.summary
