# Given the root of a binary tree, return the preorder traversal of its nodes' values.

# Preorder: self, left subtree, right subtree

# Definition for a binary tree node.
require_relative './lib/tree_node'

def preorder_traversal_rec(root)
  return [] if root.nil?
  [root.val, *preorder_traversal_rec(root.left), *preorder_traversal_rec(root.right)]
end

# Follow up: Recursive solution is trivial, could you do it iteratively?

# @param {TreeNode} root
# @return {Integer[]}
# iterative DFS with stack
def preorder_traversal(root)
  return [] if root.nil?

  stack = [root]
  out = []

  until stack.empty?
    current = stack.pop
    out << current.val

     # push right first so its processed last
    stack << current.right if current.right
    stack << current.left if current.left
  end

  out
end

require_relative './testing'
Testing.expect(
  preorder_traversal(TreeNode.from_leetcode([1,nil,2,3])),
  [1,2,3]
)
Testing.expect(
  preorder_traversal(TreeNode.from_leetcode([1,2,3,4,5,nil,8,nil,nil,6,7,9])),
  [1,2,4,5,6,7,3,8,9]
)
Testing.expect(
  preorder_traversal(TreeNode.from_leetcode([1])),
  [1]
)
Testing.expect(
  preorder_traversal(TreeNode.from_leetcode([])),
  []
)
Testing.expect(
  preorder_traversal(TreeNode.new(1, TreeNode.new(2, TreeNode.new(3)), TreeNode.new(4))),
  [1, 2, 3, 4]
)
Testing.summary
