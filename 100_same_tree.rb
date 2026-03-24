# Given the roots of two binary trees p and q,
# write a function to check if they are the same or not.

# Two binary trees are considered the same if they are structurally identical,
# and the nodes have the same value.

require_relative './lib/tree_node'

class TreeNode
  def ==(other)
    other.is_a?(TreeNode) &&
      other.val == self.val &&
      other.left == self.left &&
      other.right == self.right
  end
end

# @param {TreeNode} p
# @param {TreeNode} q
# @return {Boolean}
def is_same_tree(p, q)
  p == q
end
