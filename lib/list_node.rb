# leetcode singly-linked list
class ListNode
  attr_accessor :val, :next
  def initialize(val = 0, _next = nil)
      @val = val
      @next = _next
  end

  def self.from_a(list)
    from_leetcode(list)
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

  def to_a
    if self.next.nil?
      [self.val]
    else
      [self.val] + self.next.to_a
    end
  end
end
