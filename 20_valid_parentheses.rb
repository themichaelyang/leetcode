# Given a string s containing just the characters
# '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

# An input string is valid if:
# 1. Open brackets must be closed by the same type of brackets.
# 2. Open brackets must be closed in the correct order.
# 3. Every close bracket has a corresponding open bracket of the same type.

PARENS = {
  '(' => ')',
  '{' => '}',
  '[' => ']'
}

# @param {String} s
# @return {Boolean}
def is_valid(s)
  stack = []

  matching = s.chars.all? do |c|
    case c
    when '(', '{', '['
      stack.push(c)
    when ')', '}', ']'
      PARENS[stack.pop] == c
    end
  end

  matching && stack.empty?
end

require_relative './testing'
Testing.assert(is_valid('()'))
Testing.assert(is_valid('{}'))
Testing.assert(is_valid('[]'))
Testing.assert(is_valid('()(){}'))
Testing.assert(is_valid('(())'))
Testing.assert(is_valid('[({})]'))
Testing.assert(is_valid('[][[]]({{[]}}([]))'))
Testing.assert(is_valid(''))
Testing.refute(is_valid('{'))
Testing.refute(is_valid('{)'))
Testing.refute(is_valid('({)}'))
Testing.summary
