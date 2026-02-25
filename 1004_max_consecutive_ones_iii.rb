# Given a binary array nums and an integer k, return the maximum number of
# consecutive 1's in the array if you can flip at most k 0's.

def advance_end(nums, k, zeroes, ones, starts_at, ends_at)
  while (zeroes < k || nums[ends_at] == 1) && ends_at < nums.length
    if nums[ends_at].zero?
      zeroes += 1
    else
      ones += 1
    end

    ends_at += 1
  end

  [zeroes, ones, starts_at, ends_at]
end

def advance_start(nums, k, zeroes, ones, starts_at, ends_at)
  if nums[starts_at].zero?
    zeroes -= 1
  else
    ones -= 1
  end

  starts_at += 1

  [zeroes, ones, starts_at, ends_at]
end

# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer}
def longest_ones(nums, k)
  zeroes, ones = [0, 0]
  starts_at, ends_at = [0, 0] # [inclusive, exclusive]
  longest = 0

  # 1. advance end (fill up zeroes and greedily take ones)
  # 2. advance start (move until zero is decreased)
  # 3. repeat!

  while starts_at < nums.length
    zeroes, ones, starts_at, ends_at = advance_end(nums, k, zeroes, ones, starts_at, ends_at)
    longest = [ones + zeroes, longest].max
    zeroes, ones, starts_at, ends_at = advance_start(nums, k, zeroes, ones, starts_at, ends_at)
  end

  longest
end

require_relative './testing'
Testing.expect(longest_ones([1,1,1,0,0,0,1,1,1,1,0], 2), 6)
Testing.expect(longest_ones([0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1], 3), 10)
Testing.expect(longest_ones([0, 0, 0], 1), 1)
Testing.expect(longest_ones([0, 0, 0], 2), 2)
Testing.expect(longest_ones([0, 0, 0], 4), 3)
Testing.expect(longest_ones([0, 0, 1, 1, 0, 0], 1), 3)
Testing.expect(longest_ones([0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0], 2), 7)
Testing.expect(longest_ones([1, 1, 1, 1], 1), 4)
Testing.expect(longest_ones([1, 0, 0, 0, 1], 2), 3)
Testing.expect(longest_ones([0, 0, 1], 1), 2)
Testing.summary
