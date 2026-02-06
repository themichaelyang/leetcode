# Given an integer array nums and an integer val, remove all occurrences of val in nums in-place. The order of the elements may be changed. Then return the number of elements in nums which are not equal to val.

# Consider the number of elements in nums which are not equal to val be k, to get accepted, you need to do the following things:
# - Change the array nums such that the first k elements of nums contain the elements which are not equal to val. The remaining elements of nums are not important as well as the size of nums.
# - Return k.

# two pointer solution: replace nums[front] == val with nums[back], so long as nums[back] is != val
# keep trying to find next nums[back] != val
# keep track of the counts of nums[i] that == val for the final length of the array.

# @param {Integer[]} nums
# @param {Integer} val
# @return {Integer}
def remove_element(nums, val)
  count = 0

  front = 0 
  back = [nums.length - 1, 0].max
  
  while front <= back
    if nums[front] == val and nums[back] != val
      nums[front] = nums[back]
      
      front += 1
      back -= 1
      count += 1
    elsif nums[front] == val and nums[back] == val
      back -= 1
      count += 1
    else
      # nums[front] != val -> are there langs that can verify coverage without an else?
      front += 1
    end
  end

  nums.length - count
end