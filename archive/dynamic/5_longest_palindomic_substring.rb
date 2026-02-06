# This solution is quite slow and memory intensive.
# I wonder if tabulation would yield much better results.
# Is this due to recursion, or is there an issue with my memoization?
def longest_palindrome(str)
  memory = {}
  length, first, last = (0...(str.length)).map do |i| 
    [longest_around(str, i, i, memory), longest_around(str, i, i + 1, memory)].max
  end.max
  
  str[first..last]
end

def longest_around(str, first, last, memory)
  memory[first] ||= []
  if memory[first][last] 
    memory[first][last] 
  else
    if first < 0 || last >= str.length || str[first] != str[last]
      [0, 0, 0]
    else
      [
        [last - first + 1, first, last],
        longest_around(str, first - 1, last + 1, memory)
      ].max
    end
  end
end

# TODO: try the "expand" solution
# # This times out on Leetcode?
# def longest_palindrome(str)
#   subproblems = Array.new(str.length)
#   longest = 0..0

#   # "length" is sort of a misnomer, since it's really the difference between first and last
#   0.upto(str.length - 1).each do |length|
#     0.upto(str.length - 1 - length).each do |first|
#       last = first + length

#       subproblems[length] ||= Array.new(str.length - 1 - length)

#       if length == 0
#         subproblems[length][first] = true
#       elsif length == 1
#         subproblems[length][first] = str[first] == str[last]
#       elsif length - 2 >= 0 && first + 1 < subproblems[length - 1].length
#         subproblems[length][first] = subproblems[length - 2][first + 1] && str[first] == str[last]
#       end

#       if subproblems[length][first] && (first..last).size > longest.size
#         longest = first..last
#       end
#     end
#   end

#   str[longest]
# end

# Triangular runtime, which is O(n^2)
# This is too slow, apparently? Maybe the lambda?
# def longest_palindrome(str)
#   subproblem_store = Array.new(str.length)
#   subproblem_store.each.with_index do |_, i|
#     subproblem_store[i] = Array.new(str.length - i)
#   end
  
#   # subproblem(i, j) = true means that str[i..j] is a palindrome
#   # (i, j) depends on (i - 1, j + 1)
#   # (i, i) is always true -> single letter is a palindrome
#   # (i, i + 1) is only true if two letter palindrome

#   # We use a triangular instead of a square 2d array to save memory. 
#   # We index the subproblem_store by inverting the `last` index.
#   # e.g. The final subproblem is (0, str.length - 1), which is indexed at [0][0]

#   longest = 0..0

#   subproblem = lambda do |first, last, value=nil|
#     # Need to check bounds because of negative array indexing
#     if first >= 0 && first < str.length && last >= 0 && last < str.length
#       result = subproblem_store[first][str.length - 1 - last] ||= value

#       if value && (first..last).size > longest.size 
#         longest = (first..last)
#       end

#       result
#     else
#       false
#     end
#   end

#   0.upto(str.length - 1).each do |length|
#     0.upto(str.length - 1 - length).each do |first|
#       last = first + length

#       subproblem.(first, first, true)
#       subproblem.(first, first + 1, true) if str[first] == str[first + 1]
      
#       is_palindrome = subproblem.(first + 1, last - 1) && str[first] == str[last]
#       subproblem.(first, last, is_palindrome)
#     end
#   end

#   str[longest]
# end


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
assert_equals(longest_palindrome('abcdefggg'), 'ggg')
assert_equals(longest_palindrome('abcdefghgj'), 'ghg')
assert_equals(longest_palindrome('e' * 1000), 'e' * 1000)
assert_equals(longest_palindrome('e' * 1001), 'e' * 1001)