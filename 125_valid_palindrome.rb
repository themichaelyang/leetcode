# A phrase is a palindrome if, after converting all uppercase letters
# into lowercase letters and removing all non-alphanumeric characters,
# it reads the same forward and backward.
# Alphanumeric characters include letters and numbers.

# Given a string s, return true if it is a palindrome, or false otherwise.

# @param {String} s
# @return {Boolean}
def is_palindrome(s)
  # /i = case insensitive
  # ^ = negate char group
  str = s.downcase.gsub(/[^0-9a-z]/i, '')
  str == str.reverse
end

require_relative './testing'
Testing.assert(is_palindrome('a'))
Testing.assert(is_palindrome('aa'))
Testing.assert(is_palindrome('aaa'))
Testing.assert(is_palindrome('bab'))
Testing.assert(is_palindrome('cbabc'))
Testing.assert(is_palindrome('cba!b c'))
Testing.refute(is_palindrome('ab'))
Testing.refute(is_palindrome('abc'))
Testing.summary
