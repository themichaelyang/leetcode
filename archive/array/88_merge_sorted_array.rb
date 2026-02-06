# https://leetcode.com/problems/merge-sorted-array/

# O(m + n) time and O(m + n) additional space

# This could be improved to O(1) additional space 
# by iterating largest to smallest. This way, you don't
# replace values in nums1 that you haven't already used 
# since the index i of the merge is always behind the 
# index of the i1 of the original nums1 (m to 0).

# @param {Integer[]} nums1
# @param {Integer} m
# @param {Integer[]} nums2
# @param {Integer} n
# @return {Void} Do not return anything, modify nums1 in-place instead.
def merge(nums1, m, nums2, n)
  original_nums1 = nums1.dup
  i1 = 0
  i2 = 0

  (0...(m + n)).each do |i|
    if i2 >= n or (i1 < m and original_nums1[i1] <= nums2[i2])
      nums1[i] = original_nums1[i1]
      i1 += 1
    else
      nums1[i] = nums2[i2]
      i2 += 1
    end
  end
end