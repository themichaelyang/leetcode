# Given the root of a binary tree,
# return the level order traversal of its nodes' values.
# (i.e., from left to right, level by level).

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
# @return {Integer[][]}
def level_order(root)
  return [] if root.nil?
  # BFS!
  queue = [[root, 0]]
  out = [[]]

  until queue.empty?
    current, depth = queue.shift
    out.append([]) if depth + 1 > out.length
    out.last.append(current.val)

    queue.push([current.left, depth + 1]) if current.left
    queue.push([current.right, depth + 1]) if current.right
  end

  out
end

require_relative './testing'
Testing.expect(
  level_order(TreeNode.from_leetcode([3,9,20,nil,nil,15,7])),
  [[3],[9,20],[15,7]]
)
Testing.expect(
  level_order(TreeNode.from_leetcode([1])),
  [[1]]
)
Testing.expect(
  level_order(TreeNode.new(1, TreeNode.new(2), TreeNode.new(3, nil, TreeNode.new(4)))),
  [[1], [2, 3], [4]]
)
Testing.expect(
  level_order(TreeNode.from_leetcode([])),
  []
)
Testing.summary
