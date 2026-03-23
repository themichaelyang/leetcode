# A phrase is a palindrome if, after converting all uppercase letters
# into lowercase letters and removing all non-alphanumeric characters,
# it reads the same forward and backward.
# Alphanumeric characters include letters and numbers.

# Given a string s, return true if it is a palindrome, or false otherwise.

def is_palindrome_reverse(s)
  # /i = case insensitive
  # ^ = negate char group
  str = s.downcase.gsub(/[^0-9a-z]/i, '')
  str == str.reverse
end

# @param {String} s
# @return {Boolean}
def is_palindrome(s)
  str = s.downcase.gsub(/[^0-9a-z]/i, '')
  # ruby ranges only go left to right unfort, but compare:
  # str[0..((str.length - 1) / 2)] == str[-((str.length + 1) / 2)..-1].reverse

  0.upto(str.length / 2).all? do |i|
    str[i] == str[str.length - 1 - i]
  end
end

# 1 = -1
# 2 = -1
# 3 = -2
# 4 = -2

require_relative './testing'
Testing.assert(is_palindrome('a'))
Testing.assert(is_palindrome('aa'))
Testing.assert(is_palindrome('aaa'))
Testing.assert(is_palindrome('bab'))
Testing.assert(is_palindrome('baab'))
Testing.assert(is_palindrome('cbabc'))
Testing.assert(is_palindrome('cba!b c'))
Testing.refute(is_palindrome('ab'))
Testing.refute(is_palindrome('abc'))
Testing.summary
