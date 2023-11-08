# https://leetcode.com/problems/range-sum-query-immutable

# class NumArray
#   attr_accessor :nums

#   def initialize(nums)
#     self.nums = nums  
#   end


#   def nums=(nums)
#     @nums = nums

#     running_sum = 0
#     @prefix_sums= nums.map do |value|
#       running_sum += value
#     end
#   end

#   def sum_range(left, right)
#     @prefix_sums[right] - @prefix_sums[left] + @nums[left]
#   end
# end

# class NumArray
#   def initialize(nums)
#     sum = 0
#     @prefix_sums = nums.map do |x|
#       sum += x
#     end
#     @prefix_sums.prepend(0)
#   end

#   def sum_range(left, right)
#     @prefix_sums[right + 1] - @prefix_sums[left]
#   end
# end


class NumArray
  def initialize(nums)
    sum = 0
    @nums = nums
    @prefix_sums = nums.map do |value|
      sum += value
    end
  end

  def sum_range(left, right)
    @prefix_sums[right] - @prefix_sums[left] + @nums[left]
  end
end

# class NumArray
#   def initialize(nums)
#     @nums = nums

#     # instead of [0..i] as prefix, use [i..n] as postfix
#     sum = 0
#     @postfix_sum = nums.reverse.map do |value|
#       sum += value
#     end.reverse
#   end

#   def sum_range(left, right)
#     @postfix_sum[left] - @postfix_sum[right] + @nums[right]
#   end
# end

# class NumArray
#   def initialize(nums)
#     @nums = nums

#     # instead of [0..i] as prefix, use [i..n] as postfix
#     sum = 0
#     @postfix_sum = nums.reverse.map do |value|
#       sum += value
#     end.reverse
#     @postfix_sum.append(0)
#   end

#   def sum_range(left, right)
#     @postfix_sum[left] - @postfix_sum[right + 1]
#   end
# end

