# frozen_string_literal: true
# 1768. Merge Strings Alternately
#
# You are given two strings word1 and word2. Merge the strings by adding letters
# in alternating order, starting with word1. If a string is longer than the other,
# append the additional letters onto the end of the merged string.
#
# Return the merged string.

# def merge_alternately(word1, word2)
#   chars1 = if word2.length > word1.length
#     word1.chars.concat([nil] * (word2.length - word1.length))
#   else
#     word1.chars
#   end

#   chars1.zip(word2.chars).compact.join
# end

# Optimized a bit, not worth over optimizing cause Leetcode has high variance
# between runs.
def merge_alternately(word1, word2)
  min_len = [word1.length, word2.length].min
  output = String.new(capacity: word1.length + word2.length)
  i = 0

  while i < min_len
    output << word1[i]
    output << word2[i]
    i += 1
  end

  output << word1[i..]
  output << word2[i..]
end

require_relative 'testing'

Testing.expect(merge_alternately('abc', 'pqr'), 'apbqcr')
Testing.expect(merge_alternately('ab', 'pqrs'), 'apbqrs')
Testing.expect(merge_alternately('abcd', 'pq'), 'apbqcd')
Testing.expect(merge_alternately('dfe', 'beebda'), 'dbfeeebda')
Testing.summary
