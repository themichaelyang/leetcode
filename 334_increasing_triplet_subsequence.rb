# Given an integer array nums, return true if there exists a triple of indices (i, j, k)
# such that i < j < k and nums[i] < nums[j] < nums[k]. If no such indices exists, return false.

# @param {Integer[]} nums
# @return {Boolean}
def increasing_triplet_1(nums)
  lowest_before = Array.new(nums.length) { Float::INFINITY }
  highest_after = Array.new(nums.length) { -Float::INFINITY }

  # lowest_before[i] = min(nums[0..i])
  # highest_after[i] = max(nums[i+1..nums.length])
  (1...nums.length).each do |i|
    lowest_before[i] = [lowest_before[i - 1], nums[i - 1]].min
    highest_after[nums.length - 1 - i] = [
      highest_after[nums.length - i],
      nums[nums.length - i]
    ].max
  end

  nums.length.times.any? do |i|
    lowest_before[i] < nums[i] && nums[i] < highest_after[i]
  end
end

# Follow up: Could you implement a solution that runs in O(n) time complexity and O(1) space complexity?
def increasing_triplet(nums)
  lowest = Float::INFINITY
  second_lowest = Float::INFINITY

  nums.each do |x|
    # second lowest always has at least one lower, so x > second lowest makes a triplet
    return true if x > second_lowest

    # ratcheting the new lowest.
    if x <= lowest
      lowest = x
    elsif x < second_lowest
      second_lowest = x
    end
  end

  false
end

require_relative './testing'

Testing.expect(increasing_triplet([1, 2, 3, 4, 5]), true)
Testing.expect(increasing_triplet([1, 2, 3, 4, 5].reverse), false)
Testing.expect(increasing_triplet([2, 1, 5, 0, 4, 6]), true)
Testing.expect(increasing_triplet([5, 4, 3, 2, 6, 1, 7, 2]), true)
Testing.expect(increasing_triplet([5, 4, 3, 2, 6, 1, 5, 2]), false)
Testing.expect(increasing_triplet([1]), false)
Testing.expect(increasing_triplet([1, 1, 1]), false)
Testing.expect(increasing_triplet([1, 2, 1]), false)
Testing.expect(increasing_triplet([1, 1, 2]), false)
Testing.expect(increasing_triplet([3, 1, 2, 1, 3, 1]), true)
Testing.summary
