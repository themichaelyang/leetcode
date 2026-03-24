# Given the root of a binary tree, return the inorder traversal of its nodes' values.

# Inorder: left subtree, self, right subtree

require_relative './lib/tree_node'
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end

# recursive, just like preorder and postorder
# def inorder_traversal(root)
#   return [] if root.nil?
#   [*inorder_traversal(root.left), root.val, *inorder_traversal(root.right)]
# end

# Follow up: Recursive solution is trivial, could you do it iteratively?
# @param {TreeNode} root
# @return {Integer[]}
def inorder_traversal(root)
  return [] if root.nil?

  left_explored = {}
  stack = [root]
  out = []

  until stack.empty?
    current = stack.pop

    # only add to output after left has been visited
    if left_explored[current]
      out << current.val
    else
      left_explored[current] = true
      stack << current.right if current.right
      stack << current
      stack << current.left if current.left
    end
  end

  out
end

require_relative './testing'
Testing.expect(
  inorder_traversal(TreeNode.from_leetcode([1,nil,2,3])),
  [1,3,2]
)
Testing.expect(
  inorder_traversal(TreeNode.from_leetcode([1,2,3,4,5,nil,8,nil,nil,6,7,9])),
  [4,2,6,5,7,1,3,9,8]
)
Testing.expect(
  inorder_traversal(TreeNode.from_leetcode([1])),
  [1]
)
Testing.expect(
  inorder_traversal(TreeNode.from_leetcode([])),
  []
)
Testing.expect(
  inorder_traversal(TreeNode.new(1, TreeNode.new(2, TreeNode.new(3)), TreeNode.new(4))),
  [3, 2, 1, 4]
)
Testing.summary
