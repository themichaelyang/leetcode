# Given the head of a linked list, remove the nth node from the end of the list and return its head.

# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
require_relative "./lib/list_node"

# @param {ListNode} head
# @param {Integer} n
# @return {ListNode}
def remove_nth_from_end(head, n)
  length = count(head)

  # since we start current at head, loop after only works for n < length
  # could have also used a sentinel
  return head.next if length == n

  current = head

  (length - n - 1).times do
    current = current.next
  end

  # now we're at the node right before the one we need to remove
  current.next = current.next&.next

  head
end

def count(head)
  length = 0

  until head.nil?
    length += 1
    head = head.next
  end

  length
end

# Follow up: Could you do this in one pass?
# similar two pointer strategy as cycle finding
def remove_nth_from_end(head, n)
  sentinel = ListNode.new(:sentinel, head) # so zero indexing works

  leader = sentinel
  (n + 1).times do # so follower.next is node to remove
    leader = leader&.next
  end

  follower = sentinel
  until leader.nil?
    leader = leader.next
    follower = follower.next
  end

  follower.next = follower.next&.next

  sentinel&.next
end

require_relative "./testing"

Testing.expect(count(ListNode.from_a([1, 2, 3])), 3)
Testing.expect(count(ListNode.from_a([1])), 1)

Testing.expect(remove_nth_from_end(ListNode.from_a([1]), 1).to_a, [])
Testing.expect(remove_nth_from_end(ListNode.from_a([1, 2, 3]), 1).to_a, [1, 2])
Testing.expect(remove_nth_from_end(ListNode.from_a([1, 2, 3]), 2).to_a, [1, 3])
Testing.expect(remove_nth_from_end(ListNode.from_a([1, 2, 3]), 3).to_a, [2, 3])
Testing.expect(remove_nth_from_end(ListNode.from_a([1, 2, 3, 4, 5]), 2).to_a, [1, 2, 3, 5])

Testing.summary
