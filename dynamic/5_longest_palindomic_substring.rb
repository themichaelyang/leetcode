# This solution is quite slow and memory intensive.
# I wonder if tabulation would yield much better results.
# Is this due to recursion, or is there an issue with my memoization?
def longest_palindrome(str)
  memory = {}
  length, first, last = (0...(str.length)).flat_map do |i| 
    [longest_around(str, i, i, memory), longest_around(str, i, i + 1, memory)]
  end.max
  
  str[first..last]
end

def longest_around(str, first, last, memory)
  memory[first] ||= []
  memory[first][last] ||= if first < 0 || last >= str.length || str[first] != str[last]
    [0, 0, 0]
  else
    [
      [last - first + 1, first, last],
      longest_around(str, first - 1, last + 1, memory),
    ].max
  end
end

# This memoize is nice because we can keep a reference to the memory.
# def memoize(method_name, with: {})
#   memory = with
#   original = method(method_name)

#   define_method(method_name) do |*args|
#     if memory.include?(args)
#       memory[args]
#     else
#       memory[args] = original.call(*args)
#     end
#   end
# end

# # If we pass in memory with a reference, we can clear it
# memory = {}
# memoize(:longest_around, with: memory)

require_relative "../test"
extend TestSuite

assert_equals(longest_palindrome('a'), 'a')
assert_equals(longest_palindrome('aa'), 'aa')
assert_equals(longest_palindrome('aab'), 'aa')
assert_equals(longest_palindrome('aba'), 'aba')
assert_equals(longest_palindrome('caba'), 'aba')
assert_equals(longest_palindrome('abac'), 'aba')
assert_equals(longest_palindrome('abba'), 'abba')
assert_equals(longest_palindrome('abbaba'), 'abba')
assert_equals(longest_palindrome('e' * 1000), 'e' * 1000)
assert_equals(longest_palindrome('e' * 1001), 'e' * 1001)