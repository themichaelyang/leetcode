# Given an unsorted array of integers nums,
# return the length of the longest consecutive elements sequence.

# You must write an algorithm that runs in O(n) time.

# @param {Integer[]} nums
# @return {Integer}
def longest_consecutive(nums)
  return 0 if nums.empty?

  longest = nums[0]..nums[0]
  freq = nums.tally

  nums.each do |x|
    next if freq[x].nil?

    lower = x - 1
    until freq[lower].nil?
      freq.delete(lower)
      lower -= 1
    end

    higher = x + 1
    until freq[higher].nil?
      freq.delete(higher)
      higher += 1
    end

    consecutive = (lower + 1)..(higher - 1)
    longest = consecutive if consecutive.size > longest.size
  end

  longest.size
end

require_relative './testing'
Testing.expect(longest_consecutive([100,4,200,1,3,2]), 4)
Testing.expect(longest_consecutive([0,3,7,2,5,8,4,6,0,1]), 9)
Testing.expect(longest_consecutive([1,0,1,2]), 3)
Testing.expect(longest_consecutive([1]), 1)
Testing.expect(longest_consecutive([1, 1, 1, 1]), 1)
Testing.expect(longest_consecutive([2, 1, 1, 1]), 2)
Testing.expect(longest_consecutive([]), 0)
Testing.summary
