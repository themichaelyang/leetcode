# https://leetcode.com/problems/merge-sorted-array/

# O(m + n) time and O(m + n) additional space
# This could be improved by iterating the two pointers from:
# nums1[m] -> nums1[0]
# and nums2[n] -> nums2[0]
# this way, as you go through nums1, you don't replace values you haven't
# already merged.

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