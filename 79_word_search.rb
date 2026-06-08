# Given an m x n grid of characters board and a string word,
# return true if word exists in the grid.

# The word can be constructed from letters of sequentially adjacent cells,
# where adjacent cells are horizontally or vertically neighboring.
# The same letter cell may not be used more than once.

# @param {Character[][]} board
# @param {String} word
# @return {Boolean}
def exist(board, word)
  Board.new(board).exist?(word)
end

class Board
  attr_accessor :board, :height, :width, :visited

  def initialize(board)
    self.board = board
    self.height, self.width = board.length, board.first.length
  end

  def exist?(word)
    board_chars, word_chars = board.flatten.tally, word.chars.tally
    return false unless word_chars.all? { |ch, freq| (board_chars[ch] || 0) >= freq }

    self.visited = Array.new(height) { Array.new(width) { false } }

    height.times.any? do |y|
      width.times.any? do |x|
        dfs([y, x], 0, word)
      end
    end
  end

  # recursive backtracking template much easier than iterative to undo visit
  # this is because it tracks tree structure better. with iterative dfs with
  # stack can push an undo sentinel to the stack to unvisit a branch.
  def dfs(pos, char_at, word)
    return word[char_at] == board.dig(*pos) if char_at == word.length - 1
    return false if word[char_at] != board.dig(*pos)

    self.visited[pos.first][pos.last] = true

    available = list_neighbors(pos).reject { |nb| self.visited.dig(*nb) }
    result = available.any? do |av|
      dfs(av, char_at + 1, word)
    end

    self.visited[pos.first][pos.last] = false

    result
  end

  def list_neighbors(pos)
    coords = [[1, 0], [-1, 0], [0, 1], [0, -1]].map do |dy, dx|
      [pos.first + dy, pos.last + dx]
    end

    coords.select do |y, x|
      0 <= y && y < height && 0 <= x && x < width
    end
  end
end

require_relative "./testing"

Testing.assert(exist([["a"]], "a"))
Testing.refute(exist([["a"]], "b"))

Testing.assert(exist([["a", "b"]], "a"))
Testing.assert(exist([["a", "b"]], "ab"))
Testing.assert(exist([["a", "b"]], "b"))
Testing.assert(exist([["a", "b"]], "ba"))
Testing.refute(exist([["a", "b"]], "abc"))
Testing.refute(exist([["a", "b"]], "aa"))
Testing.refute(exist([["a", "b"]], "ac"))
Testing.refute(exist([["a", "b"]], "abb"))
Testing.refute(exist([["a", "b"]], "c"))

Testing.assert(exist([["a"], ["b"]], "a"))
Testing.assert(exist([["a"], ["b"]], "ab"))
Testing.assert(exist([["a"], ["b"]], "b"))
Testing.assert(exist([["a"], ["b"]], "ba"))
Testing.refute(exist([["a"], ["b"]], "abc"))
Testing.refute(exist([["a"], ["b"]], "aa"))
Testing.refute(exist([["a"], ["b"]], "ac"))
Testing.refute(exist([["a"], ["b"]], "aba"))
Testing.refute(exist([["a"], ["b"]], "aba"))

Testing.assert(exist([["a", "b"], ["c", "d"]], "abdc"))
Testing.assert(exist([["a", "b"], ["c", "d"]], "acdb"))
Testing.assert(exist([["a", "b"], ["c", "d"]], "cabd"))
Testing.assert(exist([["a", "b"], ["c", "d"]], "dcab"))
Testing.assert(exist([["a", "b"], ["c", "d"]], "bdc"))
Testing.assert(exist([["a", "b"], ["c", "d"]], "ab"))
Testing.assert(exist([["a", "b"], ["c", "d"]], "d"))
Testing.refute(exist([["a", "b"], ["c", "d"]], "e"))
Testing.refute(exist([["a", "b"], ["c", "d"]], "abcd"))
Testing.refute(exist([["a", "b"], ["c", "d"]], "cdab"))
Testing.refute(exist([["a", "b"], ["c", "d"]], "cb"))
Testing.refute(exist([["a", "b"], ["c", "d"]], "abcde"))
Testing.refute(exist([["a", "b"], ["c", "d"]], "abce"))

Testing.assert(exist([["a", "a", "a"], ["b", "b", "a"], ["a", "a", "a"]], "aaaaaaa"))
Testing.assert(exist([["a", "a", "a"], ["b", "b", "a"], ["a", "a", "a"]], "abaab"))

Testing.assert(exist([["C", "A", "A"], ["A", "A", "A"], ["B", "C", "D"]], "AAB"))
Testing.refute(exist(
  [["A", "A", "A", "A", "A", "A"],
   ["A", "A", "A", "A", "A", "A"],
   ["A", "A", "A", "A", "A", "A"],
   ["A", "A", "A", "A", "A", "A"],
   ["A", "A", "A", "A", "A", "A"],
   ["A", "A", "A", "A", "A", "A"]],
  "AAAAAAAAAAAAAAB"
))

Testing.summary
