
# Given the head of a linked list, return the node where the cycle begins.
# If there is no cycle, return null.
#
# There is a cycle in a linked list if there is some node in the list that
# can be reached again by continuously following the next pointer.
# Internally, pos is used to denote the index of the node that tail's next pointer is connected to (0-indexed).
# It is -1 if there is no cycle. Note that pos is not passed as a parameter.
#
# Do not modify the linked list.

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

    raise if cycle_pos >= nodes.length
    nodes.last.next = nodes[cycle_pos] if cycle_pos >= 0

    nodes
  end
end

# Follow up: Can you solve it using O(1) (i.e. constant) memory?

# @param {ListNode} head
# @return {ListNode}
def detectCycle(head)
  false if head.nil?

  # floyd's to find if there is a cycle
  tortoise, hare = [head, head]
  steps = 0

  loop do
    steps += 1
    tortoise = tortoise&.next
    hare = hare&.next&.next
    break if tortoise == hare
  end

  # no cycle
  return nil if tortoise.nil?

  # the meeting point is at node index -b mod c,
  # so it's b steps away from the cycle start
  # (where b is index of start of cycle)
  # so we start a chaser at list start (b steps away) that meets up
  # at the cycle start
  chaser = head

  until chaser == tortoise
    tortoise = tortoise.next
    chaser = chaser.next
  end

  chaser
end

def detect_cycle(list, pos)
  nodes = ListNode.from_leetcode(list, pos)
  cycle_start = detectCycle(nodes.first)
  nodes.index(cycle_start)
end

require_relative './testing'
Testing.expect(detect_cycle([], -1), nil)
Testing.expect(detect_cycle([1], -1), nil)
Testing.expect(detect_cycle([1], 0), 0)
Testing.expect(detect_cycle([1, 2, 3], -1), nil)
Testing.expect(detect_cycle([1, 2, 3], 2), 2)
Testing.expect(detect_cycle([1,2], 0), 0)
Testing.expect(detect_cycle([3,2,0,-4], 1), 1)
Testing.summary
