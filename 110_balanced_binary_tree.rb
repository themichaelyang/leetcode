# Given a binary tree, determine if it is height-balanced.

# height-balanced: depth of two subtrees of any node never differs by more than 1

require_relative './lib/tree_node'

# @param {TreeNode} root
# @return {Boolean}
# O(n log n): O(log n) for height call, called n times (once per node)
# O(n^2) worst case due to O(n) height call for skewed tree
# def is_balanced(root)
#   return true if root.nil?

#   (height(root.left) - height(root.right)).abs <= 1 \
#     && is_balanced(root.left) \
#     && is_balanced(root.right)
# end

# could add memoization because this is O(n) for a skewed tree, although
# that slows the leetcode speed down
# def height(root)
#   return 0 if root.nil?

#   [height(root.left), height(root.right)].max + 1
# end

# @param {TreeNode} root
# @return {Boolean}
# O(n) single pass
def is_balanced(root)
  height_and_balance(root).last
end

def height_and_balance(node)
  return [0, true] if node.nil?
  left_height, left_balance = height_and_balance(node.left)
  right_height, right_balance = height_and_balance(node.right)

  [
    [left_height, right_height].max + 1,
    (left_height - right_height).abs <= 1 && left_balance && right_balance
  ]
end

require_relative './testing'
Testing.assert(is_balanced(TreeNode.from_leetcode([3,9,20,nil,nil,15,7])))
Testing.refute(is_balanced(TreeNode.from_leetcode([1,2,2,3,3,nil,nil,4,4])))
Testing.assert(is_balanced(TreeNode.from_leetcode([])))

Testing.summary
