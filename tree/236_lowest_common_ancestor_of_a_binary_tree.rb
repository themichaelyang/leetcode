# https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/

# Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.

# According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”

# Definition for a binary tree node.
class TreeNode
    attr_accessor :val, :left, :right
    def initialize(val)
        @val = val
        @left, @right = nil, nil
    end

    def inspect
      "<TreeNode: #{@val}>"
    end
end

# @param {TreeNode} root
# @param {TreeNode} p
# @param {TreeNode} q
# @return {TreeNode}
def lowest_common_ancestor(root, p, q)
  p, p_path = find_node_and_path(root, p)
  q, q_path = find_node_and_path(root, q)

  lowest_ancestor = root
  p_path.each_with_index do |node, i|
    if node == q_path[i]
      lowest_ancestor = node
    else
      break
    end
  end

  lowest_ancestor
end

def find_node_and_path(root, node)
  queue = [root]
  parents = {root => nil}
  while current = queue.shift()
    if current == node
      found = current
      break
    else 
      if current.left
        queue.push(current.left)
        parents[current.left] = current
      end

      if current.right
        queue.push(current.right)
        parents[current.right] = current
      end
    end
  end

  if found
    [found, find_path(found, parents)]
  else
    [nil, []]
  end
end

def find_path(dest, parents)
  path = [dest]
  node = dest
  while node = parents[node]
    path.prepend(node)
  end

  path
end

require_relative '../test'
extend TestSuite

c = TreeNode.new(3)
b = TreeNode.new(2)
a = TreeNode.new(1)
a.left = b
a.right = c
assert_equals(find_node_and_path(a, c), [c, [a, c]])