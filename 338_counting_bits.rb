# Given an integer n, return an array ans of length n + 1
# such that for each i (0 <= i <= n),
# ans[i] is the number of 1's in the binary representation of i.

# @param {Integer} n
# @return {Integer[]}
# def count_bits(n)
#   return [0] if n == 0

#   (n + 1).times.map do |x|
#     x.to_s(2).count('1')
#   end
# end

# Follow up:
# - It is very easy to come up with a solution with a runtime of O(n log n).
#   Can you do it in linear time O(n) and possibly in a single pass?
#
# - Can you do it without using any built-in function
#   (i.e., like __builtin_popcount in C++)?

# O(n) using the hint: Divide the numbers in ranges like [2-3], [4-7], [8-15] and so on. And try to generate new range from previous.
# there's a simpler way backtracking on ones[i >> 1] + (i & 1), but i still like my solution
def count_bits(n)
  return [0] if n == 0

  ones = Array.new(n + 1)
  ones[0] = 0
  ones[1] = 1

  range = [0, 1]
  digits = 1

  # 0 1
  # -> 10 11 00 01
  # -> 110 111 101 100 000 001
  while ones[n].nil?
    msb = 1 << digits

    range.length.times do |i|
      num = range[i]
      range << (msb | num)
      ones[range.last] = ones[num] + 1
    end

    digits += 1
  end

  ones[..n]
end

require_relative './testing'
Testing.expect(count_bits(0), [0])
Testing.expect(count_bits(5), [0,1,1,2,1,2])
Testing.summary
