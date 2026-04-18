# You are given two non-empty linked lists representing two non-negative integers.
# The digits are stored in reverse order, and each of their nodes contains a single digit.
# Add the two numbers and return the sum as a linked list.

# You may assume the two numbers do not contain any leading zero, except the number 0 itself.


# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
require_relative './lib/list_node'

# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
def add_two_numbers(l1, l2)
  out_sentinel = ListNode.new # so we can append to it

  out_digit = out_sentinel
  l1_digit = l1
  l2_digit = l2
  carry = 0

  until l1_digit.nil? && l2_digit.nil? && carry == 0
    v1 = l1_digit&.val || 0
    v2 = l2_digit&.val || 0
    sum = v1 + v2 + carry

    digit, carry = if sum >= 10
      [sum % 10, 1] # could use divmod and int trunc
    else
      [sum, 0]
    end

    out_digit.next = ListNode.new(digit)

    out_digit = out_digit.next
    l1_digit = l1_digit&.next
    l2_digit = l2_digit&.next
  end

  out_sentinel.next
end

def test_add(a, b)
  added = add_two_numbers(
    ListNode.from_a(a.to_s.chars.reverse.map(&:to_i)),
    ListNode.from_a(b.to_s.chars.reverse.map(&:to_i))
  )

  Testing.expect(added.to_a.reverse.map(&:to_s).join.to_i, a + b)
end

require_relative './testing'
test_add(1, 2)
test_add(0, 1)
test_add(123, 345)
test_add(12, 1235135)
test_add(999, 1)
test_add(9, 1)
test_add(99, 113)
Testing.summary
