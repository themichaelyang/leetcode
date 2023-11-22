# You are given a 0-indexed integer array nums of length n.
# We want to group the indices so for each index i in the range [0, n - 1], it is assigned to exactly one group.
#
# A group assignment is valid if the following conditions hold:
# - For every group g, all indices i assigned to group g have the same value in nums.
# - For any two groups g1 and g2, the difference between the number of indices assigned to g1 and g2 should not exceed 1.
# Return an integer denoting the minimum number of groups needed to create a valid group assignment.

def min_groups_for_valid_assignment(nums)
  counts = nums.tally
  smallest = counts.values.min

  (1..smallest).map do |min_size|
    max_size = min_size + 1

    counts.sum do |num, size|
      if size % max_size == 0
        size / max_size
      elsif max_size - (size % max_size) <= size / max_size 
        # we can take from the groups of max_size to balance out the remainder
        (size / max_size) + 1
      elsif (size % min_size) <= size / min_size
        # we can distribute the remainder among the groups of min_size
        size / min_size
      else
        Float::INFINITY
      end
    end
  end.min
end

require_relative "./test"
extend TestSuite

assert_equals(min_groups_for_valid_assignment([1, 2]), 2)
assert_equals(min_groups_for_valid_assignment([1]), 1)
assert_equals(min_groups_for_valid_assignment([1, 1]), 1)
assert_equals(min_groups_for_valid_assignment([1, 1, 2, 2, 3, 3]), 3)
assert_equals(min_groups_for_valid_assignment([1] * 10 + [2] * 3), 4)

assert_equals(min_groups_for_valid_assignment([3, 2, 3, 2, 3]), 2)
assert_equals(min_groups_for_valid_assignment([10, 10, 10, 3, 1, 1]), 4)