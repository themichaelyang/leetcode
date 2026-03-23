# Given two strings s and t,
# return true if t is an anagram of s, and false otherwise.

# @param {String} s
# @param {String} t
# @return {Boolean}
def is_anagram(s, t)
  s.chars.tally == t.chars.tally
end

require_relative 'testing'
Testing.assert(is_anagram('', ''))
Testing.assert(is_anagram('a', 'a'))
Testing.assert(is_anagram('rat', 'tar'))
Testing.refute(is_anagram('a', 'aa'))
Testing.refute(is_anagram('ab', 'baa'))
Testing.assert(is_anagram('tomato', 'tomato'))
Testing.assert(is_anagram('squash', 'hasqus'))
Testing.summary
