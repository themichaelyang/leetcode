# You are given an integer array height of length n. There are n vertical lines
# drawn such that the two endpoints of the ith line are (i, 0) and (i, height[i]).

# Find two lines that together with the x-axis form a container, such that the
# container contains the most water.

# Return the maximum amount of water a container can store.

# Notice that you may not slant the container.

# @param {Integer[]} height
# @return {Integer}
def max_area(height)
  # if reducing width, we can only improve by raising the shorter side.
  # we won't skip the optimal since anything we skip would be worse, and
  # the solution is always within the initial bounds
  left = 0
  right = height.length - 1
  most = 0

  while left < right
    shorter = [height[left], height[right]].min
    width = right - left
    most = [shorter * width, most].max

    if height[left] < height[right]
      left += 1
    else
      right -= 1
    end
  end

  most
end

require_relative 'testing'
Testing.expect(max_area([1, 8, 6, 2, 5, 4, 8, 3, 7]), 49)
Testing.expect(max_area([1, 1]), 1)
Testing.expect(max_area([1, 2]), 1)
Testing.expect(max_area([1, 2, 1]), 2)
Testing.expect(max_area([1, 2, 2]), 2)
Testing.expect(max_area([1, 2, 3]), 2)
Testing.expect(max_area([1, 3, 2, 3, 1]), 6)
Testing.expect(max_area([1, 3, 2, 3, 3]), 9)
Testing.expect(max_area([7, 95, 100, 3, 8]), 95)
Testing.summary
