# Given an input string s, reverse the order of the words.

# A word is defined as a sequence of non-space characters.
# The words in s will be separated by at least one space.

# Return a string of the words in reverse order concatenated by a single space.

# Note that s may contain leading or trailing spaces or multiple spaces between two words.
# The returned string should only have a single space separating the words.
# Do not include any extra spaces.

# @param {String} s
# @return {String}
def reverse_words(s)
  s.split.reverse.join(' ')
end

require_relative './testing'
Testing.expect(reverse_words("the sky is blue"), "blue is sky the")
Testing.expect(reverse_words("  hello world  "), "world hello")
Testing.expect(reverse_words("a good   example"), "example good a")
Testing.expect(reverse_words("hi"), "hi")
Testing.expect(reverse_words("hi    "), "hi")
Testing.expect(reverse_words("hi there"), "there hi")
Testing.summary
