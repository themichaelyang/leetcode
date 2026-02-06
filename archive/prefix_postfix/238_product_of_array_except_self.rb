# https://leetcode.com/problems/product-of-array-except-self/description/

# Given an integer array nums, return an array answer such that answer[i] is 
# equal to the product of all the elements of nums except nums[i].

# def product_except_self(nums)
#   # We trim the last value and prepend a 1, since we don't want the current index in the product.
#   left_products = cumulative_product(nums)[0..-2].prepend(1)
#   right_products = cumulative_product(nums.reverse_each)[0..-2].prepend(1).reverse

#   left_products.zip(right_products).map {|arr| arr.reduce(:*)}
# end

# def cumulative_product(iter)
#   product = 1
#   iter.map {|x| product *= x}
# end

# Follow up: Can you solve the problem in O(1) extra space complexity? (The output array does not count as extra space for space complexity analysis.)
# I hope .each_with_index isn't allocating space. map! could also work...
def product_except_self(nums)
  n = nums.length
  result = [1] * n

  # Populate result with left product
  result.each_index do |i|

    # Keep the first value 1, so that we ignore the value at i. This is "except self"
    next if i == 0

    result[i] = result[i - 1] * nums[i - 1]
  end
  # Now, result[i] is the exclusive left product of i

  # Iterate to get the right product, while using the existing left product to populate the result
  right_product = 1
  result.each_index do |i|
    j = n - i - 1

    left_product = result[j]
    result[j] = left_product * right_product

    # We also need to exclude the current index in the right product, so we multiply only after populating result
    right_product *= nums[j]
  end

  result
end

def test(actual, expected)
  if actual != expected
    puts "found: #{actual}, expected: #{expected}"
  end
end

test(product_except_self([1,2,3,4]), [24,12,8,6])


