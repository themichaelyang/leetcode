# You are given the heads of two sorted linked lists `list1` and `list2`.

# Merge the two lists into one sorted list.
# The list should be made by splicing together the nodes of the first two lists.

# Return the head of the merged linked list.

# Definition for singly-linked list.
# class ListNode
#   attr_accessor :val, :next
#   def initialize(val = 0, _next = nil)
#       @val = val
#       @next = _next
#   end
# end
require_relative './lib/list_node'

def take_smallest(list1, list2)
  if [list1&.val, list2&.val].compact.min == list1&.val
    [list1, list1&.next, list2]
  else
    [list2, list1, list2&.next]
  end
end

# @param {ListNode} list1
# @param {ListNode} list2
# @return {ListNode}
# another idea for head is to use a sentinel then return sentinel.next
# if we don't want to do work outside the loop
def merge_two_lists(list1, list2)
  head, list1, list2 = take_smallest(list1, list2)
  prev = head

  until list1.nil? && list2.nil?
    node, list1, list2 = take_smallest(list1, list2)
    prev.next = node
    prev = node
  end

  head
end

def merge_lists(list1, list2)
  merge_two_lists(
    ListNode.from_leetcode(list1),
    ListNode.from_leetcode(list2),
  ).to_a
end

require_relative './testing'
Testing.expect(merge_lists([1,2,4], [1,3,4]), [1,1,2,3,4,4])
Testing.expect(merge_lists([], []), [])
Testing.expect(merge_lists([], [0]), [0])
Testing.expect(merge_lists([1], [1]), [1, 1])
Testing.expect(merge_lists([2], [1]), [1, 2])
Testing.expect(merge_lists([2, 3, 4], [1]), [1, 2, 3, 4])
Testing.expect(merge_lists([1, 2, 3, 4], [5, 6]), [1, 2, 3, 4, 5, 6])
Testing.expect(merge_lists([1, 100, 100], [5, 6, 101]), [1, 5, 6, 100, 100, 101])
Testing.summary
