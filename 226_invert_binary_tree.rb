# Given the root of a binary tree, invert the tree, and return its root.

# Definition for a binary tree node.
require_relative './lib/tree_node'

# @param {TreeNode} root
# @return {TreeNode}
# recursive
# def invert_tree(root)
#   return nil if root.nil?

#   left = invert_tree(root.left)
#   right = invert_tree(root.right)

#   root.right = left
#   root.left = right

#   root
# end

# @param {TreeNode} root
# @return {TreeNode}
# iterative
def invert_tree(root)
  return nil if root.nil?

  stack = [root]

  until stack.empty?
    current = stack.pop
    current.left, current.right = current.right, current.left
    stack << current.left if current.left
    stack << current.right if current.right
  end

  root
end

require_relative './testing'
Testing.expect(
  invert_tree(TreeNode.from_leetcode([4,2,7,1,3,6,9])),
  TreeNode.from_leetcode([4,7,2,9,6,3,1])
)
Testing.expect(
  invert_tree(TreeNode.from_leetcode([2,1,3])),
  TreeNode.from_leetcode([2,3,1])
)
Testing.expect(
  invert_tree(TreeNode.from_leetcode([])),
  TreeNode.from_leetcode([])
)
Testing.expect(
  invert_tree(TreeNode.from_leetcode([1])),
  TreeNode.from_leetcode([1])
)
Testing.summary
