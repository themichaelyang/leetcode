class TreeNode
  # standard leetcode binary tree
  attr_accessor :val, :left, :right
  def initialize(val=0, left=nil, right=nil)
    @val = val
    @left = left
    @right = right
  end

  # ======================================== #
  # custom methods (for debugging and tests) #
  # ======================================== #

  # format: https://support.leetcode.com/hc/en-us/articles/32442719377939-How-to-create-test-cases-on-LeetCode#h_01J5EGREAW3NAEJ14XC07GRW1A
  # deserializing from leetcode style level order format
  # this is a very literal level order approach,
  # but could also bfs level order with a queue
  def self.from_leetcode(list)
    return nil if list.nil? || list.length == 0
    nodes = list.map { |val| TreeNode.new(val) if val }

    root = nodes.first
    prev_level_nodes = [root].compact # only non nil nodes

    expected = prev_level_nodes.length * 2
    level = [] # includes nils

    nodes.each_with_index do |node, i|
      next if i == 0

      level << node

      if node
        parent = prev_level_nodes[(level.length - 1) / 2]
        if level.length % 2 == 1 # left node
          parent.left = node
        else # right node
          parent.right = node
        end
      end

      if level.length == expected
        prev_level_nodes = level.compact
        expected = prev_level_nodes.length * 2
        level = []
      end
    end

    root
  end

  def ==(other)
    other.is_a?(TreeNode) &&
      val == other.val &&
      left == other.left &&
      right == other.right
  end

  def to_s
    # "<TreeNode(#{@val}), left: #{@left || 'nil'}, right: #{@right || 'nil'}>"
    "<TreeNode(#{@val})" + (@left ? ", left: #{@left}" : "") + (@right ? ", right: #{@right}" : "") + ">"
  end

  def inspect
    to_s
  end
end
