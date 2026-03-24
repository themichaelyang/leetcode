# Given the root of a binary tree, return the postorder traversal of its nodes' values.

# Postorder: left subtree, right subtree, self

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

# def postorder_traversal(root)
#   return [] if root.nil?
#   [*postorder_traversal(root.left), *postorder_traversal(root.right), root.val]
# end

# Follow up: Recursive solution is trivial, could you do it iteratively?

# # postfix reversal trick
# def postorder_traversal(root)
#   return [] if root.nil?

#   visited = Set.new
#   stack = [root]
#   out = []

#   until stack.empty?
#     current = stack.pop
#     out << current.val
#     stack << current.left if current.left
#     stack << current.right if current.right
#   end

#   out.reverse
# end

# @param {TreeNode} root
# @return {Integer[]}

# using visited, no reversal trick
def postorder_traversal(root)
  return [] if root.nil?

  explored = {}
  stack = [root]
  out = []

  until stack.empty?
    current = stack.pop

    # only add to output after children have been visited
    if explored[current]
      out << current.val
    else
      # since children are stacked after, they will be explored by the
      # time we re-pop current
      explored[current] = true
      stack << current
      stack << current.right if current.right
      stack << current.left if current.left
    end
  end

  out
end

require_relative './testing'
Testing.expect(
  postorder_traversal(TreeNode.from_leetcode([1,nil,2,3])),
  [3,2,1]
)
Testing.expect(
  postorder_traversal(TreeNode.from_leetcode([1,2,3,4,5,nil,8,nil,nil,6,7,9])),
  [4,6,7,5,2,9,8,3,1]
)
Testing.expect(
  postorder_traversal(TreeNode.from_leetcode([1])),
  [1]
)
Testing.expect(
  postorder_traversal(TreeNode.from_leetcode([])),
  []
)
Testing.summary
