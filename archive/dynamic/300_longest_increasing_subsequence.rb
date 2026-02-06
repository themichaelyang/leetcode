# Given an integer array nums, return the length of the longest strictly increasing subsequence.
# Follow up: Can you come up with an algorithm that runs in O(n log(n)) time complexity?

# recursive with memoization
def length_of_lis(nums)
  longest = []
  memory = []
  
  0.upto(nums.length - 1).map do |i|
    longest_including(nums, i, memory)
  end.max { |a, b| a.length <=> b.length }.length
end

def longest_including(nums, index, memory)
  return memory[index] if memory[index]

  longest = [nums[index]]

  0.upto(index - 1).each do |i|
    if nums[index] > nums[i] 
      # this list append is what slows it down, if we just want the length this can be faster
      # I think instead of keeping the whole list around we can backtrack to recover the longest
      # longest_with_i = longest_including(nums, i, memory) + [nums[index]]
      # if longest_with_i.length > longest.length
      #   longest = longest_with_i
      # end

      longest_with_i 
    end
  end

  memory[index] = longest
end

# tabulation: O(n^2)
def length_of_lis(nums)
  # longest_from[i] gives the previous index that longest lis including index i is from
  longest_from = [nil] * nums.length
  longest_including = [1] * nums.length

  longest = 1
  longest_last_index = 0

  0.upto(nums.length - 1).each do |i|
    0.upto(i - 1).each do |j|

      if nums[i] > nums[j]
        longest_from_j = longest_including[j] + 1
        
        if longest_from_j > longest_including[i]
          longest_including[i] = longest_from_j
          longest_from[i] = j
        end
      end
    end

    if longest_including[i] > longest 
      longest = longest_including[i]
      longest_last_index = i
    end
  end

  longest
  # backtrack_lis(longest_from, longest_last_index, [])
end

# to efficiently recover the lis
def backtrack_lis(longest_from, last_index, lis)
  if last_index
    lis.unshift(last_index)
    
    backtrack_lis(longest_from, longest_from[last_index], lis)
  else
    lis
  end
end

require_relative "../test"
extend TestSuite

assert_equals(length_of_lis([1]), 1)
assert_equals(length_of_lis([1, 2]), 2)
assert_equals(length_of_lis([1, 3, 2]), 2)
assert_equals(length_of_lis([1, 3, 2, 4]), 3)
assert_equals(length_of_lis([1, 5, 4, 3, 2, 1]), 2)
assert_equals(length_of_lis((1..200).to_a), 200)