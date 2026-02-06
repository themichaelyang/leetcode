# https://leetcode.com/problems/number-of-digit-one/
# tags: digit-dp

# Given an integer n, count the total number of digit 1 appearing in all non-negative integers less than or equal to n.

def count_digit_one(n)
  descend_digits(n.digits.reverse, 0, true, 0)
end

def memoize(method_name)
  memory = {}
  original = method(method_name)

  # Needs to rebind the method name because of the recursive calls in the original method
  define_method(method_name) do |*args|
    if memory.include?(args)
      memory[args] 
    else
      memory[args] = original.call(*args)
    end
  end
end

memoize def descend_digits(digits, i, prefix_matches_n, ones)
  digit = digits[i]
  return ones if digit.nil?

  largest_digit = if prefix_matches_n then digit else 9 end

  (0..largest_digit).sum do |next_digit|
    next_ones = if next_digit == 1 then ones + 1 else ones end
    next_prefix_matches_n = prefix_matches_n && next_digit == digit
    
    descend_digits(digits, i + 1, next_prefix_matches_n, next_ones)
  end
end

# memoize def descend_digits(digits, i, max_prefix, ones)
#   digit = digits[i]

#   return ones if digit.nil?
  
#   total = 0

#   # if previous digits match n
#   if max_prefix

#     # stick close to n
#     if digit == 1
#       total += descend_digits(digits, i + 1, true, ones + 1)
#     else
#       total += descend_digits(digits, i + 1, true, ones)
#     end

#     if digit > 1
#       # if can include a 1 when smaller than n, include a 1
#       total += descend_digits(digits, i + 1, false, ones + 1)
#     end

#     # As Ishaan notes, it's easier to reason about if you collapse this logic.
#     if digit != 0
#       # go smaller than n, exclude digit and 1 as options.
#       # we ignore 0 because it's been added with max_prefix=true
#       total += [(digit - 1), 1].max * descend_digits(digits, i + 1, false, ones)
#     end

#     total
#   else
#     # include a 1
#     total += descend_digits(digits, i + 1, false, ones + 1)

#     # don't include a 1
#     total += 9 * descend_digits(digits, i + 1, false, ones) 
#   end
# end

require_relative './test'
extend TestSuite

assert_equals(count_digit_one(0), 0)
assert_equals(count_digit_one(1), 1)
assert_equals(count_digit_one(9), 1)
assert_equals(count_digit_one(10), 2)
assert_equals(count_digit_one(11), 4)
assert_equals(count_digit_one(13), 6)