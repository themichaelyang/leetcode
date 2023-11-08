
require_relative "../test"

# Given a 2D matrix matrix, handle multiple queries of the following type:
# - Calculate the sum of the elements of matrix inside the rectangle defined by its upper left corner (row1, col1) and lower right corner (row2, col2).

# Implement the NumMatrix class:
# - NumMatrix(int[][] matrix) Initializes the object with the integer matrix matrix.
# - int sumRegion(int row1, int col1, int row2, int col2) Returns the sum of the elements of matrix inside the rectangle defined by its upper left corner (row1, col1) and lower right corner (row2, col2).

# You must design an algorithm where sumRegion works on O(1) time complexity.

class NumMatrix 
  # (0, 0) is the top left
  def initialize(matrix)
    @corner_areas = matrix
    @corner_areas.each.with_index do |row, y|
      row.each.with_index do |value, x|
        upper_sum = positive_dig(@corner_areas, y - 1, x)
        left_sum = positive_dig(@corner_areas, y, x - 1)

        # Subtract inner corner area to remove duplicate sums from top and left
        @corner_areas[y][x] = value + upper_sum + left_sum - positive_dig(@corner_areas, y - 1, x - 1)
      end
    end
  end

  # 
  #          c1 - 1       c2
  #        ┌─────┼─────────┼──┐
  #        │  A  │    B    │  │
  # r1 - 1 ┼─────┼─────────┤  │
  #        │  C  │    D    │  │
  # r2 ----┼─────┴─────────┘  │
  #        └──────────────────┘
  # upper left corner (row1, col1) and lower right corner (row2, col2).
  # 
  # O(1) after initialization
  def sum_region(row1, col1, row2, col2)
    # Need to subtract - 1 from upper right corner, otherwise it will delete the corner of the region we want to sum!
    inner_area = positive_dig(@corner_areas, row1 - 1, col1 - 1)
    full_area = positive_dig(@corner_areas, row2, col2)

    left_area = positive_dig(@corner_areas, row2, col1 - 1)
    upper_area = positive_dig(@corner_areas, row1 - 1, col2)

    full_area - left_area - upper_area + inner_area
  end

  def positive_dig(arr, *indices)
    # We need to filter these otherwise Ruby will negative index from end of array
    if indices.any?(&:negative?)
      0
    else
      arr.dig(*indices)
    end
  end
end

extend TestSuite
inputs = [[[[3, 0, 1, 4, 2], [5, 6, 3, 2, 1], [1, 2, 0, 1, 5], [4, 1, 0, 1, 7], [1, 0, 3, 0, 5]]], [2, 1, 4, 3], [1, 1, 2, 2], [1, 2, 2, 4]]
outputs = [nil, 8, 11, 12]

in_out = inputs.zip(outputs)
matrix, _ = in_out.shift[0]

num_matrix = NumMatrix.new(matrix)

in_out.each do |input, output|
  assert_equals(num_matrix.sum_region(*input), output)
end
