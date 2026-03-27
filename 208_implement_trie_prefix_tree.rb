# A trie (pronounced as "try") or prefix tree is a tree data structure used
# to efficiently store and retrieve keys in a dataset of strings.
# There are various applications of this data structure, such as autocomplete and spellchecker.

# Implement the Trie class:
# - Trie() Initializes the trie object.
# - void insert(String word)
#   Inserts the string word into the trie.
# - boolean search(String word)
#   Returns true if the string word is in the trie (i.e., was inserted before), and false otherwise.
# - boolean startsWith(String prefix)
#   Returns true if there is a previously inserted string word that has the prefix prefix, and false otherwise.

class Trie
  def initialize()
    @trie = {}
  end

  #: (String) -> void
  def insert(word)
    subtree = @trie

    word.chars.each do |char|
      subtree[char] ||= {}
      subtree = subtree[char]
    end

    subtree[:end] = true
    nil
  end

  #: (String) -> bool
  def search(word)
    !!@trie.dig(*word.chars)&.dig(:end)
  end

  #: (String) -> bool
  def starts_with(prefix)
    !!@trie.dig(*prefix.chars)
  end

  def self.from_leetcode(ops, params)
    trie = nil
    ops.each_with_index.map do |op, i|
      case op
      when 'Trie' then trie = Trie.new; nil
      when 'insert' then trie.insert(*params[i])
      when 'search' then trie.search(*params[i])
      when 'startsWith' then trie.starts_with(*params[i])
      end
    end
  end
end

# Your Trie object will be instantiated and called as such:
# obj = Trie.new()
# obj.insert(word)
# param_2 = obj.search(word)
# param_3 = obj.starts_with(prefix)

require_relative './testing'

Testing.expect(
  Trie.from_leetcode(
    ["Trie", "insert", "search", "search", "startsWith", "insert", "search"],
    [[], ["apple"], ["apple"], ["app"], ["app"], ["app"], ["app"]]
  ),
  [nil, nil, true, false, true, nil, true]
)
Testing.summary
