# Definition for singly-linked list.
class ListNode
  attr_accessor :val, :next
  def initialize(val)
    @val = val
    @next = nil
  end

  def self.from_leetcode(list, cycle_pos=-1)
    nodes = list.map do |val|
      ListNode.new(val)
    end

    nodes.each_cons(2).each do |prev, curr|
      prev.next = curr
    end

    nodes.last.next = nodes[cycle_pos] if cycle_pos >= 0

    nodes.first
  end
end

# node = ListNode.from_leetcode([3,2,0,-4], 1)
# loop do
#   puts node.val
#   node = node.next
#   break if node.nil?
#   sleep 1
# end

# Follow up: Can you solve it using O(1) (i.e. constant) memory?

# @param {ListNode} head
# @return {Boolean}
# annoyed that this isn't snake_case in leetcode
# O(1) space with floyds
def hasCycle(head)
  false if head.nil?
  tortoise, hare = [head, head]

  loop do
    tortoise = tortoise&.next
    hare = hare&.next&.next
    return false if hare.nil?
    break if tortoise == hare
  end

  !tortoise.nil?
end

require_relative './testing'
Testing.assert(hasCycle(ListNode.from_leetcode([3,2,0,-4], 1)))
Testing.assert(hasCycle(ListNode.from_leetcode([1, 2], 0)))
Testing.refute(hasCycle(ListNode.from_leetcode([1, 2], -1)))
Testing.assert(hasCycle(ListNode.from_leetcode([1], 0)))
Testing.refute(hasCycle(ListNode.from_leetcode([], -1)))
Testing.summary
