# Given a binary tree, find the lowest common ancestor (LCA)
# of two given nodes in the tree.

# According to the definition of LCA on Wikipedia:
# “The lowest common ancestor is defined between two nodes p and q
# as the lowest node in T that has both p and q as descendants
# (where we allow a node to be a descendant of itself).”

# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end
require_relative './lib/tree_node.rb'

# @param {TreeNode} root
# @param {TreeNode} p
# @param {TreeNode} q
# @return {TreeNode}
# seems like p and q are references, not copies
def lowest_common_ancestor(root, p, q)
  # p "root: #{root&.val}"
  if root.nil?
    nil
  elsif root == p
    putr(is_subtree?(root, q) ? root : :p)
  elsif root == q
    putr(is_subtree?(root, p) ? root : :q)
  else
    lca_left = lowest_common_ancestor(root.left, p, q)
    return putr(lca_left) if lca_left.is_a? TreeNode
    lca_right = lowest_common_ancestor(root.right, p, q)
    return putr(lca_right) if lca_right.is_a? TreeNode

    if [lca_left, lca_right].compact.sort == [:p, :q]
      root
    else
      [lca_left, lca_right].compact.first
    end
  end
end

def putr(val)
  # puts val
  val
end

def is_subtree?(root, tree)
  return root == tree if root.nil?
  root == tree || is_subtree?(root.left, tree) || is_subtree?(root.right, tree)
end

def find_node(nodes, val)
  nodes.find {|node| node&.val == val}
end

require_relative './testing.rb'
def leetcode_lca(tree_def, p_val, q_val)
  root, nodes = TreeNode.from_leetcode(tree_def, true)
  lca = lowest_common_ancestor(root, find_node(nodes, p_val), find_node(nodes, q_val))
  # nodes.find_index(lca)
  lca&.val
end
Testing.expect(leetcode_lca([3,5,1,6,2,0,8,nil,nil,7,4], 5, 1), 3)
Testing.expect(leetcode_lca([3,5,1,6,2,0,8,nil,nil,7,4], 5, 4), 5)
Testing.summary
