# https://leetcode.com/problems/house-robber/

# You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security systems connected and it will automatically contact the police if two adjacent houses were broken into on the same night.

# Given an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.

# def rob(nums)
#   rob_impl(nums, 0)
# end

# https://nithinbekal.com/posts/ruby-memoization/
# https://stackoverflow.com/questions/35595047/how-to-generically-memoize-any-function-in-ruby
# We could use a Class instance to hold the memory
# def memoize(method_name)
#   memory = {}
#   original = method(method_name)

#   # Needs to rebind the method name because of the recursive calls in the original method
#   define_method(method_name) do |*args|
#     if memory.include?(args)
#       memory[args] 
#     else
#       memory[args] = original.call(*args)
#     end
#   end
# end

# memoize def rob_impl(nums, start_index)
#   if start_index >= nums.length - 1
#     nums[start_index] || 0
#   else
#     [
#       nums[start_index] + rob_impl(nums, start_index + 2),
#       rob_impl(nums, start_index + 1)
#     ].max
#   end
# end

# Solution that reuses input space for O(1) add. space
# def rob(nums)
#   # nums[i] after iterating over means the max at i houses
#   (0...nums.length).each do |i|
#     nums[i] = [zero_dig(nums, i - 2) + nums[i], zero_dig(nums, i - 1)].max
#   end

#   nums.last
# end

# def zero_dig(arr, i)
#   if i < 0
#     0
#   else
#     arr[i]
#   end
# end

# Solution that uses O(1) additional space, without reusing the input
# def rob(nums)
#   prev_prev = nums[0] || 0
#   prev = [prev_prev, nums[1] || 0].max
#   best = prev

#   (2...nums.length).each do |i|
#     current = [prev_prev + nums[i], prev].max
#     prev_prev = prev
#     prev = current

#     best = [current, best].max
#   end

#   best
# end

# Solution that uses O(1) additional space, without reusing the input
def rob(nums)
  prev_prev = 0
  prev = 0
  best = 0

  (0...nums.length).each do |i|
    current = [prev_prev + nums[i], prev].max
    prev_prev = prev
    prev = current

    best = [current, best].max
  end

  best
end

require_relative "../test"
extend TestSuite

assert_equals(rob([1,2,3,1]), 4)
assert_equals(rob([2,7,9,3,1]), 12)
assert_equals(rob([2,1,1,2]), 4)


