# Design a data structure that supports adding new words and finding
# if a string matches any previously added string.

# Implement the WordDictionary class:
# - WordDictionary() Initializes the object.
# - void addWord(word) Adds word to the data structure, it can be matched later.
# - bool search(word) Returns true if there is any string in the data structure that matches word
# or false otherwise. word may contain dots '.' where dots can be matched with any letter.

class WordDictionary
  def initialize
    @trie = {}
  end

  #: (String) -> void
  def add_word(word)
    prev = @trie

    word.chars.each do |c|
      prev = (prev[c] ||= {})
    end

    prev[:end] = {} # since we rely on nil access
    nil
  end

  #: (String) -> bool
  # this is a bfs, which is inefficient since it finds *all* wildcard matches
  # instead of just one. dfs will short circuit on first found match.
  def search_all(word)
    branches = [@trie]

    word.chars.each do |c|
      branches.each_with_index do |branch, i|
        if c == "."
          branches[i] = branches[i].values
        else
          branches[i] = branches[i][c]
        end
      end

      branches.compact!
      branches.flatten!
      return false if branches.empty?
    end

    branches.any? { |br| br[:end] }
  end

  # dfs
  def search(word)
    stack = [[@trie, 0]]

    until stack.empty?
      branch, i = stack.pop
      c = word[i]

      return true if i == word.length && branch[:end]

      if c == "."
        branch.values.each { |subtree| stack.push([subtree, i + 1]) }
      elsif branch[c]
        stack.push([branch[c], i + 1])
      end
    end

    false
  end
end

# Your WordDictionary object will be instantiated and called as such:
# obj = WordDictionary.new()
# obj.add_word(word)
# param_2 = obj.search(word)

require_relative "./testing"

def test_leetcode(instructions, parameters, expected)
  dict = nil

  actual = instructions.zip(parameters).map do |instr, params|
    case instr
    when "WordDictionary" then dict = WordDictionary.new; nil
    when "addWord" then dict.add_word(params.first)
    when "search" then dict.search(params.first)
    end
  end

  Testing.expect(actual, expected)
end

test_leetcode(
  ["WordDictionary", "addWord", "addWord", "addWord", "search", "search", "search", "search"],
  [[], ["bad"], ["dad"], ["mad"], ["pad"], ["bad"], [".ad"], ["b.."]],
  [nil, nil, nil, nil, false, true, true, true]
)

dict = WordDictionary.new
Testing.refute(dict.search("h"))
Testing.refute(dict.search("."))
Testing.refute(dict.search("hello"))

dict.add_word("hello")
Testing.assert(dict.search("hello"))
Testing.refute(dict.search("world"))
Testing.refute(dict.search("help"))
Testing.assert(dict.search(".ello"))
Testing.assert(dict.search("h.llo"))
Testing.assert(dict.search("hell."))
Testing.assert(dict.search("....."))
Testing.refute(dict.search("h"))
Testing.refute(dict.search("."))
Testing.refute(dict.search("helloo"))
Testing.refute(dict.search("......"))
Testing.refute(dict.search("..w.."))
Testing.refute(dict.search("...."))

dict.add_word("world")
Testing.assert(dict.search("hello"))
Testing.assert(dict.search("world"))
Testing.refute(dict.search("help"))
Testing.refute(dict.search("......"))
Testing.refute(dict.search(".....a"))
Testing.refute(dict.search("horld"))
Testing.refute(dict.search("worl"))
Testing.refute(dict.search("orld"))
Testing.assert(dict.search(".or.d"))
Testing.assert(dict.search("...l."))
Testing.refute(dict.search("...."))

dict.add_word("help")
Testing.assert(dict.search("hello"))
Testing.assert(dict.search("help"))
Testing.assert(dict.search("world"))
Testing.refute(dict.search("he"))
Testing.refute(dict.search("hel"))
Testing.refute(dict.search("helpo"))
Testing.assert(dict.search("hel."))
Testing.assert(dict.search("...."))
Testing.refute(dict.search("..."))
Testing.refute(dict.search("......"))
Testing.refute(dict.search("welp"))
Testing.refute(dict.search("green"))
Testing.assert(dict.search(".el."))
Testing.assert(dict.search("h..."))

dict.add_word("he")
Testing.assert(dict.search("he"))
Testing.assert(dict.search("hello"))
Testing.assert(dict.search("help"))
Testing.assert(dict.search("world"))
Testing.refute(dict.search("h"))
Testing.refute(dict.search("he."))
Testing.assert(dict.search(".e"))
Testing.assert(dict.search(".."))
Testing.refute(dict.search("we"))

Testing.summary
