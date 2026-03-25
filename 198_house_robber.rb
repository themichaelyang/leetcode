# You are a professional robber planning to rob houses along a street.
# Each house has a certain amount of money stashed,
# the only constraint stopping you from robbing each of them is
# that adjacent houses have security systems connected and it will
# automatically contact the police if two adjacent houses were broken into on the same night.

# Given an integer array nums representing the amount of money of each house,
# return the maximum amount of money you can rob tonight without alerting the police.

# @param {Integer[]} nums
# @return {Integer}
def rob(nums)
  loot = nums.dup
  loot[2] = loot[0] + nums[2] if loot.length >= 3

  # why is -2 and -3 sufficient? it's always better to rob both -2 and -4
  # than just -4, so -2 handles the -4 (and beyond) cases. same with -5 (and beyond),
  # which is handled by -3.
  3.upto(loot.length - 1) do |i|
    loot[i] = [
      loot[i - 2],
      loot[i - 3]
    ].max + nums[i]
  end

  [loot[-1], loot[-2]].compact.max
end

require_relative './testing'
Testing.expect(rob([1,2,3,1]), 4)
Testing.expect(rob([2,7,9,3,1]), 12)
Testing.expect(rob([1]), 1)
Testing.expect(rob([1, 2]), 2)
Testing.expect(rob([3, 100, 2]), 100)
Testing.expect(rob([1, 1, 1, 1, 0, 1, 2]), 4)
Testing.summary
