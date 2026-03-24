require_relative './tree_node'
require_relative '../testing'

# test ==
Testing.expect(TreeNode.new(1), TreeNode.new(1))
Testing.expect(
  TreeNode.new(1, TreeNode.new(2), TreeNode.new(3)),
  TreeNode.new(1, TreeNode.new(2), TreeNode.new(3)),
)
Testing.refute(
  TreeNode.new(1, TreeNode.new(2), TreeNode.new(3)) == \
  TreeNode.new(1, TreeNode.new(3), TreeNode.new(2))
)

Testing.expect(
  TreeNode.from_leetcode([1]),
  TreeNode.new(1)
)
Testing.expect(
  TreeNode.from_leetcode([1, 2, 3]),
  TreeNode.new(1, TreeNode.new(2), TreeNode.new(3))
)
Testing.expect(
  TreeNode.from_leetcode([1, nil, 2, 3]),
  TreeNode.new(1, nil, TreeNode.new(2, TreeNode.new(3)))
)
Testing.expect(
  TreeNode.from_leetcode([
           5,
       4,      7,
     3, nil, 2, nil,
  -1, nil, 9]
  ),
  TreeNode.new(
    5,
    TreeNode.new(4, TreeNode.new(3, TreeNode.new(-1))),
    TreeNode.new(7, TreeNode.new(2, TreeNode.new(9)))
  )
)
Testing.expect(
  TreeNode.from_leetcode([
                     1,
              2,            3,
          4,    nil,    nil,    5,
      6,      7,           8,      9,
  nil, 10,  11, 12,    nil, nil, nil, 14
  ]),
  TreeNode.new(
    1,
    TreeNode.new(2, TreeNode.new(4, TreeNode.new(6, nil, TreeNode.new(10)), TreeNode.new(7, TreeNode.new(11), TreeNode.new(12)))),
    TreeNode.new(3, nil, TreeNode.new(5, TreeNode.new(8), TreeNode.new(9, nil, TreeNode.new(14))))
  )
)
Testing.summary
