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

  # deserializing from leetcode style level order format
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

require_relative '../testing'

# test ==
Testing.expect(TreeNode.new(1), TreeNode.new(1))
Testing.expect(
  TreeNode.new(1, TreeNode.new(2), TreeNode.new(3)),
  TreeNode.new(1, TreeNode.new(2), TreeNode.new(3)),
)
Testing.refute(
  TreeNode.new(1, TreeNode.new(2), TreeNode.new(3)) == \
  TreeNode.new(1, TreeNode.new(3), TreeNode.new(2))
)

Testing.expect(
  TreeNode.from_leetcode([1]),
  TreeNode.new(1)
)
Testing.expect(
  TreeNode.from_leetcode([1, 2, 3]),
  TreeNode.new(1, TreeNode.new(2), TreeNode.new(3))
)
Testing.expect(
  TreeNode.from_leetcode([1, nil, 2, 3]),
  TreeNode.new(1, nil, TreeNode.new(2, TreeNode.new(3)))
)
Testing.expect(
  TreeNode.from_leetcode([
           5,
       4,      7,
     3, nil, 2, nil,
  -1, nil, 9]
  ),
  TreeNode.new(
    5,
    TreeNode.new(4, TreeNode.new(3, TreeNode.new(-1))),
    TreeNode.new(7, TreeNode.new(2, TreeNode.new(9)))
  )
)
Testing.summary
