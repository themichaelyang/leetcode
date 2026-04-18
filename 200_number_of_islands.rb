# Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water),
# return the number of islands.

# An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically.
# You may assume all four edges of the grid are all surrounded by water.

# 1 = land, 0 = water

def fill(start_y, start_x, name, grid, visited)
  stack = [[start_y, start_x]]

  until stack.empty?
    y, x = stack.pop

    next if grid[y][x] == '0'
    next unless visited[y][x].nil?

    visited[y][x] = name

    stack << [y + 1, x] if y + 1 < grid.length
    stack << [y, x + 1] if x + 1 < grid.first.length
    stack << [y - 1, x] if y - 1 >= 0
    stack << [y, x - 1] if x - 1 >= 0
  end
end

# @param {Character[][]} grid
# @return {Integer}
def num_islands(grid)
  visited = Array.new(grid.length) { Array.new(grid.first.length) }
  count = 1

  grid.each_with_index do |row, y|
    row.each_with_index do |item, x|
      if visited[y][x].nil? && grid[y][x] == '1'
        fill(y, x, count, grid, visited)
        count += 1
      end
    end
  end

  count - 1
end

require_relative './testing'
Testing.expect(
  num_islands([
    ["1","1","1","1","0"],
    ["1","1","0","1","0"],
    ["1","1","0","0","0"],
    ["0","0","0","0","0"]
  ]), 1
)
Testing.expect(
  num_islands([
    ["1","1","0","0","0"],
    ["1","1","0","0","0"],
    ["0","0","1","0","0"],
    ["0","0","0","1","1"]
  ]), 3
)
Testing.expect(
  num_islands([
    ["1","0","0","1","1"],
    ["1","1","1","0","1"],
    ["0","0","1","1","0"],
    ["1","0","0","1","1"]
  ]), 3
)
Testing.expect(
  num_islands([
    ["1","0"],
    ["0","1"]
  ]), 2
)
Testing.expect(
  num_islands([
    ["0","0"],
    ["0","0"]
  ]), 0
)
Testing.summary
