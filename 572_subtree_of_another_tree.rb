# Given the roots of two binary trees `root` and `subRoot`,
# return true if there is a subtree of root with the same structure and node values of `subRoot` and false otherwise.

# A subtree of a binary tree `tree` is a tree that consists of a node in `tree`
# and all of this node's descendants.
# The tree `tree` could also be considered as a subtree of itself.


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

def same_tree?(tree, other)
  return tree == other if tree.nil? || other.nil?

  tree&.val == other&.val &&
    same_tree?(tree.left, other.left) &&
    same_tree?(tree.right, other.right)
end

# @param {TreeNode} root
# @param {TreeNode} sub_root
# @return {Boolean}
# apparently also possible in O(m + n), using same ideas as substring checking
# (or cleverly serialize into string and directly check substring)
def is_subtree(root, sub_root)
  return root == sub_root if root.nil? || sub_root.nil?

  same_tree?(root, sub_root) ||
    is_subtree(root.left, sub_root) ||
    is_subtree(root.right, sub_root)
end

require_relative './testing'
Testing.assert(
  is_subtree(
    TreeNode.from_leetcode([3,4,5,1,2]),
    TreeNode.from_leetcode([4,1,2])
  )
)
Testing.refute(
  is_subtree(
    TreeNode.from_leetcode([3,4,5,1,2,nil,nil,nil,nil,0]),
    TreeNode.from_leetcode([4,1,2])
  )
)
Testing.refute(
  is_subtree(
    TreeNode.from_leetcode([3,4,5,1,nil,2]),
    TreeNode.from_leetcode([3,1,2])
  )
)
Testing.summary
