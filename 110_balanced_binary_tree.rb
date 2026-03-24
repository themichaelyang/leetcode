# Given a binary tree, determine if it is height-balanced.

# height-balanced: depth of two subtrees of any node never differs by more than 1

require_relative './lib/tree_node'

# @param {TreeNode} root
# @return {Boolean}
def is_balanced(root)
  return true if root.nil?

  (height(root.left) - height(root.right)).abs <= 1 \
    && is_balanced(root.left) \
    && is_balanced(root.right)
end

def height(root)
  return 0 if root.nil?

  [height(root.left), height(root.right)].max + 1
end

require_relative './testing'
Testing.assert(is_balanced(TreeNode.from_leetcode([3,9,20,nil,nil,15,7])))
Testing.refute(is_balanced(TreeNode.from_leetcode([1,2,2,3,3,nil,nil,4,4])))
Testing.assert(is_balanced(TreeNode.from_leetcode([])))

Testing.summary
