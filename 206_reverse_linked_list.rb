# Given the head of a singly linked list, reverse the list,
# and return the reversed list.

# Definition for singly-linked list.
class ListNode
  attr_accessor :val, :next
  def initialize(val = 0, nxt = nil)
      @val = val
      @next = nxt
  end

  def to_a
    if self.next.nil?
      [self.val]
    else
      [self.val] + self.next.to_a
    end
  end
end

# A -> B -> C
# A <- B <- C

#        A -> B -> nil
# nil <- A <- B

# @param {ListNode} head
# @return {ListNode}
def reverse_list(head)
  reverse_list_impl(head)[:head]
end

def reverse_list_impl(node)
  if node.next.nil?
    {head: node, parent: node}
  else
    parents = reverse_list_impl(node.next)
    parents[:parent].next = node
    parents[:parent] = node
    node.next = nil
    parents
  end
end

require_relative './testing'
Testing.expect(ListNode.new(1).to_a, [1])
Testing.expect(ListNode.new(1, ListNode.new(2, ListNode.new(3))).to_a, [1, 2, 3])
Testing.expect(reverse_list(ListNode.new(1, ListNode.new(2, ListNode.new(3)))).to_a, [3, 2, 1])
Testing.summary
