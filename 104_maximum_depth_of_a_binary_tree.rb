# Given the root of a binary tree, return its maximum depth.

# A binary tree's maximum depth is the number of nodes along
# the longest path from the root node down to the farthest leaf node.

# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
require_relative './lib/tree_node'

# @param {TreeNode} root
# @return {Integer}
def max_depth(root)
  return 0 if root.nil?
  [max_depth(root.left), max_depth(root.right)].max + 1
end

require_relative './testing'
Testing.expect(
  max_depth(TreeNode.from_leetcode([3,9,20,nil,nil,15,7])), 3
)
Testing.expect(
  max_depth(TreeNode.from_leetcode([1,nil,2])), 2
)
Testing.expect(
  max_depth(TreeNode.from_leetcode([])), 0
)
Testing.expect(
  max_depth(TreeNode.from_leetcode([1])), 1
)
Testing.expect(
  max_depth(TreeNode.from_leetcode([1, 2, 3, 4, 5, 6, 7])), 3
)
Testing.summary
