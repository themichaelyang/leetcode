# Given an m x n grid of characters board and a string word,
# return true if word exists in the grid.

# The word can be constructed from letters of sequentially adjacent cells,
# where adjacent cells are horizontally or vertically neighboring.
# The same letter cell may not be used more than once.

# "Character" comes from the leetcode template (should prob be String)
# @param {Character[][]} board
# @param {String} word
# @return {Boolean}
def exist(board, word)
  height = board.length
  width = board.first.length
  visited = Array.new(height) { Array.new(width) { false } }

  height.times do |y|
    width.times do |x|
      stack = [[[y, x], 0]]

      until stack.empty?
        board_pos, char_at = stack.pop
        board_char = board.dig(*board_pos)
        visited[board_pos.first][board_pos.last] = true

        if word[char_at] == board_char
          return true if char_at == word.length - 1

          neighbors = list_neighbors(board_pos, width, height)
          candidates = neighbors.reject { |pos| visited.dig(*pos) }
          candidates.each { |c| stack.push([c, char_at + 1]) }
        else
          visited[board_pos.first][board_pos.last] = false
        end
      end
    end
  end

  false
end

def list_neighbors(pos, width, height)
  coords = [[1, 0], [-1, 0], [0, 1], [0, -1]].map do |dy, dx|
    [pos.first + dy, pos.last + dx]
  end

  coords.select do |y, x|
    0 <= y && y < height && 0 <= x && x < width
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

Testing.summary
