# Given an array of strings strs, group the anagrams together. You can return the answer in any order.

# @param {String[]} strs
# @return {String[][]}
def group_anagrams_sorting(strs)
  strs.group_by {|s| s.chars.sort }.map {|k, v| v}
end

def freq_arr(str)
  freq = Array.new(26) { 0 }
  str.each_char do |c|
    freq[c.ord - 'a'.ord] += 1
  end
  freq
end

# solution suggested by neetcode, actually slower for me
def group_anagrams(strs)
  strs.group_by {|s| freq_arr(s) }.map {|k, v| v}
end

require_relative 'testing'

class Array
  def comparable
    self.map(&:sort).sort
  end
end

Testing.expect(
  group_anagrams(["eat","tea","tan","ate","nat","bat"]).comparable,
  [["bat"],["nat","tan"],["ate","eat","tea"]].comparable
)
Testing.expect(
  group_anagrams([""]),
  [[""]]
)
Testing.expect(
  group_anagrams(["cat", "ccat"]),
  [["cat"], ["ccat"]]
)
Testing.summary
