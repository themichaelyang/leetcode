# Given an array nums of distinct integers, return all the possible permutations.
# You can return the answer in any order.

# permutations = order matters, use once

# @param {Integer[]} nums
# @return {Integer[][]}
def permute(nums, perm=[])
  return [perm] if nums.empty?

  nums.each_with_index.flat_map do |x, i|
    permute(nums[0...i] + nums[(i+1)..], perm + [x])
  end
end

require_relative './testing'
Testing.expect(permute([1]), [[1]])
Testing.expect(permute([1, 2]), [[1, 2], [2, 1]])
Testing.expect(permute([1, 2, 3]), [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]])
Testing.summary
