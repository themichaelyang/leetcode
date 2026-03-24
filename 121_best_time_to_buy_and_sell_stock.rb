# You are given an array prices where prices[i] is the price of
# a given stock on the ith day.

# You want to maximize your profit by choosing a single day to
# buy one stock and choosing a different day in the future to sell that stock.

# Return the maximum profit you can achieve from this transaction.
# If you cannot achieve any profit, return 0.

# @param {Integer[]} prices
# @return {Integer}
def max_profit(prices)
  # highest_after[i] = prices[i..].max
  highest_after = Array.new(prices.length)
  highest_after[-1] = prices.last

  # lowest_before[i] = prices[..i].min
  lowest_before = Array.new(prices.length)
  lowest_before[0] = prices.first

  (1..(prices.length - 1)).each do |i|
    highest_after[-i - 1] = [prices[-i], highest_after[-i]].max
    lowest_before[i] = [prices[i], lowest_before[i - 1]].min
  end

  prices.length.times.map { |i| highest_after[i] - lowest_before[i] }.max
end

require_relative './testing'
Testing.expect(max_profit([7,1,5,3,6,4]), 5)
Testing.expect(max_profit([7,6,4,3,1]), 0)
Testing.expect(max_profit([1, 2, 3, 4, 5]), 4)
Testing.expect(max_profit([4, 2, 3, 100, 2]), 98)
Testing.summary
