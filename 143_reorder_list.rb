# You are given the head of a singly linked-list. The list can be represented as:
# L_0 → L_1 → … → L_{n - 1} → L_n

# Reorder the list to be on the following form:
# L_0 → L_n → L_1 → L_{n - 1} → L_2 → L_{n - 2} → …

# You may not modify the values in the list's nodes. Only nodes themselves may be changed.

# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
require_relative './lib/list_node'

# 0 -> 1
# 0 -> 2 -> 1
# 0 -> 3 -> 1 -> 2
# round the halfway point down 3 / 2 = 1

def reverse!(node)
  before = nil
  current = node

  # A -> B -> C
  while current            # current = B, before = A
    after = current.next   # after = C
    current.next = before  # B -> A
    before = current       # before = B
    current = after        # current = C
  end

  before
end

# could also achieve without length by using a fast/slow runner
def length(node)
  count = 0

  until node.nil?
    node = node.next
    count += 1
  end

  count
end

def skip(node, count)
  ret = node

  while count > 0
    ret = ret&.next
    count -= 1
  end

  ret
end

def zip!(node1, node2)
  return nil if node1.nil? && node2.nil?
  return node1 if node2.nil?
  return node2 if node1.nil?

  head = node1
  last = node1
  current, other = node2, node1.next

  until current.nil? && other.nil?
    if current
      last.next = current
      last = current
    end

    current, other = other, current&.next
  end

  head
end

def split!(node, length)
  return nil if node.nil?

  end_of_first_list = skip(node, length - 1)
  start_of_second_list = end_of_first_list&.next
  end_of_first_list.next = nil

  start_of_second_list
end

# @param {ListNode} head
# @return {Void} Do not return anything, modify head in-place instead.
def reorder_list(head)
  return nil if head.nil?

  halfway = split!(head, length(head) / 2) # halfway rounding down
  reversed_half = reverse!(halfway)

  zip!(head, reversed_half)
end

require_relative './testing'
Testing.expect(
  zip!(nil, ListNode.from_a([1, 2, 3])).to_a,
  [1, 2, 3]
)
Testing.expect(
  zip!(ListNode.from_a([1, 2, 3]), nil).to_a,
  [1, 2, 3]
)
Testing.expect(
  zip!(
    ListNode.from_a([1, 2, 3]),
    ListNode.from_a(['a', 'b', 'c']),
  ).to_a,
  [1, 'a', 2, 'b', 3, 'c']
)
Testing.expect(
  zip!(
    ListNode.from_a([1, 2, 3, 4]),
    ListNode.from_a(['a', 'b', 'c']),
  ).to_a,
  [1, 'a', 2, 'b', 3, 'c', 4]
)
Testing.expect(
  zip!(
    ListNode.from_a([1, 2, 3, 4, 5]),
    ListNode.from_a(['a', 'b', 'c']),
  ).to_a,
  [1, 'a', 2, 'b', 3, 'c', 4, 5]
)
Testing.expect(
  zip!(
    ListNode.from_a([1, 2]),
    ListNode.from_a(['a', 'b', 'c', 'd']),
  ).to_a,
  [1, 'a', 2, 'b', 'c', 'd']
)
Testing.expect(
  skip(ListNode.from_a([1, 2, 3, 4, 5]), 1).to_a,
  [2, 3, 4, 5]
)
Testing.expect(
  skip(ListNode.from_a([1, 2, 3, 4, 5]), 0).to_a,
  [1, 2, 3, 4, 5]
)
Testing.expect(
  skip(ListNode.from_a([1, 2, 3, 4, 5]), 6),
  nil
)
Testing.expect(
  reverse!(ListNode.from_a([1, 2, 3, 4, 5])).to_a,
  [5, 4, 3, 2, 1]
)
Testing.expect(
  length(ListNode.from_a([1, 2, 3, 4])),
  4
)
Testing.expect(
  reorder_list(ListNode.from_a([2,4,6,8])).to_a,
  [2,8,4,6]
)
Testing.expect(
  reorder_list(ListNode.from_a([2,4,6,8,10])).to_a,
  [2,10,4,8,6]
)
Testing.expect(
  reorder_list(ListNode.from_a([1])).to_a,
  [1]
)
Testing.expect(
  reorder_list(ListNode.from_a([1, 2])).to_a,
  [1, 2]
)
Testing.expect(
  reorder_list(ListNode.from_a([1, 2, 3])).to_a,
  [1, 3, 2]
)
Testing.expect(
  reorder_list(ListNode.from_a([1, 2, 3, 4])).to_a,
  [1, 4, 2, 3]
)
Testing.summary
