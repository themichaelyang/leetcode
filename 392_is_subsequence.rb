# Given two strings s and t, return true if s is a subsequence of t,
# or false otherwise.

# A subsequence of a string is a new string that is formed from the original string
# by deleting some (can be none) of the characters without disturbing the relative
# positions of the remaining characters.
# (i.e., "ace" is a subsequence of "abcde" while "aec" is not).

# @param {String} s
# @param {String} t
# @return {Boolean}
def is_subsequence(s, t)
  t.chars.reduce(0) { |si, tc| si + (s[si] == tc ? 1 : 0) } == s.length
end

require_relative 'testing'
Testing.expect(is_subsequence('a', 'a'), true)
Testing.expect(is_subsequence('a', 'aa'), true)
Testing.expect(is_subsequence('a', 'aaa'), true)
Testing.expect(is_subsequence('b', 'a'), false)
Testing.expect(is_subsequence('b', 'ab'), true)
Testing.expect(is_subsequence('b', 'ba'), true)
Testing.expect(is_subsequence('ab', 'ba'), false)
Testing.expect(is_subsequence('ab', 'abc'), true)
Testing.expect(is_subsequence('bc', 'abdce'), true)
Testing.expect(is_subsequence('ace', 'abcde'), true)
Testing.expect(is_subsequence('aec', 'abcde'), false)
Testing.expect(is_subsequence('abc', 'ahbgdc'), true)
Testing.expect(is_subsequence('axc', 'ahbgdc'), false)
Testing.expect(is_subsequence('abc', 'aabbcc'), true)
Testing.expect(is_subsequence('abc', 'zgfhabc'), true)
Testing.summary
