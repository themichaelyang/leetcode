# Given an integer array nums,
# return true if any value appears at least twice in the array,
# and return false if every element is distinct.

# @param {Integer[]} nums
# @return {Boolean}
def contains_duplicate(nums)
  nums.tally.any? { |x, cnt| cnt >= 2 }
end
