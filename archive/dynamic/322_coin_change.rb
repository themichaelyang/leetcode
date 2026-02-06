# https://leetcode.com/problems/coin-change/

# You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.

# Return the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.

# You may assume that you have an infinite number of each kind of coin.

# For some reason, only iterative DP passes Leetcode

# def coin_change(coins, amount)
#   result = coin_change_iterative(coins, amount)
#   if result.infinite?
#     -1
#   else
#     result
#   end
# end

# def coin_change_iterative(coins, amount)
#   change = Array.new(amount)

#   change[0] = 0

#   coins.each do |denom|
#     change[denom] = 1 if denom < change.length
#   end

#   0.upto(amount).each do |i|
#     change[i] ||= coins.map do |denom|
#       inf_dig(change, i - denom) + 1
#     end.min
#   end

#   change[amount]
# end

# def inf_dig(arr, i)
#   if i < 0
#     Float::INFINITY
#   else
#     arr[i]
#   end
# end

# Normal recursive solution 
# If we don't nest mem[coins][amount], it passes leetcode. 
# Investigate why!

def coin_change(coins, amount)
  result = coin_change_impl(coins, amount, {})

  if result.infinite?
    -1
  else
    result
  end
end

# Complexity: O(amount * coins) time, since each call takes O(coins) time
# and there are O(amount) calls
# 
# O(amount) space, since the cache is bounded by amount
def coin_change_impl(coins, amount, mem)
  if amount < 0
    Float::INFINITY 
  elsif mem[amount]
    mem[amount]
  else
    mem[amount] = if amount == 0
      0
    else
      coins.map do |denom|
        coin_change_impl(coins, amount - denom, mem)
      end.min + 1
    end
  end
end


# 
# Class based approach:
# 

# def coin_change(coins, amount)
#   CoinChange.new(coins).call(amount)
# end

# module Memoized
#   def memoize(method_name)
#     original = self.instance_method(method_name)
#     # Needs to redefine the method name because of the recursive calls in the original method
#     self.define_method(method_name) do |*args|
#       # Only use instance variables in instance method definition body
#       @memory ||= {}
#       @memory[method_name] ||= {}

#       if @memory[method_name].include?(args)
#         @memory[method_name][args]
#       else
#         @memory[method_name][args] = original.bind(self).call(*args)
#       end
#     end
#   end
# end


# class CoinChange
#   extend Memoized

#   def initialize(units)
#     @units = units
#   end

#   def call(amount)
#     result = impl(amount)

#     if result.infinite?
#       -1
#     else
#       result
#     end
#   end
  
#   memoize def impl(amount)
#     if amount < 0
#       Float::INFINITY
#     elsif amount == 0
#       0
#     else
#       possible_coins = @units.map do |denom|
#         impl(amount - denom) + 1
#       end.min
#     end
#   end
# end

require_relative "../test"
extend TestSuite

assert_equals(coin_change([1, 2, 5], 11), 3)
assert_equals(coin_change([2], 3), -1)
assert_equals(coin_change([2147483647], 2), -1)
# assert_equals(coin_change([388,232,419,338,49,434,4,143], 4993), 13)
# assert_equals(coin_change([244,125,459,120,316,68,357,320], 9793), 23)
