# Given an integer numRows, return the first numRows of Pascal's triangle.
# In Pascal's triangle, each number is the sum of the two numbers directly above it as shown:

# @param {Integer} num_rows
# @return {Integer[][]}
def generate(num_rows)
  pascal = [[1]]

  (num_rows - 1).times do |row|
    pascal << (0..(pascal.last.length)).map do |i|
      left = i - 1 >= 0 ? pascal.last[i - 1] : 0 # -1 will wrap around
      right = pascal.last[i] || 0 # nil if over indexed
      left + right
    end
  end

  pascal
end

require_relative './testing'
Testing.expect(generate(1), [[1]])
Testing.expect(generate(5), [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]])
Testing.summary
