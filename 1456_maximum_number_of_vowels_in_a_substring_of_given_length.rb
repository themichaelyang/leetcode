# Given a string s and an integer k, return the maximum number of vowel letters
# in any substring of s with length k.

# Vowel letters in English are 'a', 'e', 'i', 'o', and 'u'.

# @param {String} s
# @param {Integer} k
# @return {Integer}
def max_vowels(s, k)
  vowels = 'aeiou'
  cnt = s[...k].count(vowels)

  (k...s.length).reduce(cnt) do |most, i|
    cnt += vowels.include?(s[i]) ? 1 : 0
    cnt -= vowels.include?(s[i - k]) ? 1 : 0
    [cnt, most].max
  end
end

require_relative 'testing'
Testing.expect(max_vowels('abciiidef', 3), 3)
Testing.expect(max_vowels('aeiou', 2), 2)
Testing.expect(max_vowels('leetcode', 3), 2)
Testing.expect(max_vowels('a', 1), 1)
Testing.expect(max_vowels('bcdfg', 2), 0)
Testing.expect(max_vowels('abcde', 5), 2)
Testing.summary
