# @param {String[]} strs
# @return {String[][]}
def group_anagrams(strs)
  strs.group_by {|s| s.chars.sort }.map {|k, v| v}
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
