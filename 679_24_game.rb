Expr = Struct.new(:left, :operation, :right) do
  def inspect 
    to_s
  end

  def to_s
    "(#{left.to_s} #{operation} #{right.to_s})"
  end
end

def expr(*args)
  Expr.new(*args)
end

def evaluate(expr)
  left_value = if expr.left.is_a? Expr
    evaluate(expr.left)
  else
    expr.left.to_r
  end

  right_value = if expr.right.is_a? Expr
    evaluate(expr.right)
  else
    expr.right.to_r
  end

  begin
    left_value.send(expr.operation, right_value)
  rescue ZeroDivisionError
    Float::INFINITY
  end
end

# Explicitly write down all possible trees
def twenty_four(a, b, c, d)
  all_operations = [:+, :/, :*, :-].repeated_permutation(3).to_a
  all_values = [a, b, c, d].permutation.to_a

  all_values.product(all_operations).flat_map do |values, operations|
    v1, v2, v3, v4 = values 
    op1, op2, op3 = operations

    left_tree = expr(expr(expr(v1, op1, v2), op2, v3), op3, v4)
    left_right_tree = expr(expr(v1, op1, expr(v2, op2, v3)), op3, v4)
    balanced_tree = expr(expr(v1, op1, v2), op2, expr(v3, op3, v4))
    right_left_tree = expr(v1, op1, expr(expr(v2, op2, v3), op3, v4))
    right_tree = expr(v1, op1, expr(v2, op2, expr(v3, op3, v4)))
    
    [left_tree, left_right_tree, balanced_tree, right_left_tree, right_tree].select do |expr|
      evaluate(expr) == 24
    end
  end.uniq
end

# Ishaan's solution: https://pastebin.com/s67Rgt9m

# def twenty_four_balanced(a, b, c, d)
#   all_operations = [:+, :/, :*, :-].repeated_permutation(3).to_a
#   all_values = [a, b, c, d].map(&:to_r).permutation.to_a

#   all_values.product(all_operations).flat_map do |values, operations|
#     v1, v2, v3, v4 = values 
#     op1, op2, op3 = operations

#     left_tree = [[[v1, op1, v2], op2, v3], op3, v4]
#     left_right_tree = [[v1, op1, [v2, op2, v3]], op3, v4]
#     balanced_tree = [[v1, op1, v2], op2, [v3, op3, v4]]
#     right_left_tree = [v1, op1, [[v2, op2, v3], op3, v4]]
#     right_tree = [v1, op1, [v2, op2, [v3, op3, v4]]]
    
#     [left_tree, left_right_tree, balanced_tree, right_left_tree, right_tree].select do |expr|
#       eval_arr(expr) == 24
#     end
#   end.uniq
# end

# def eval_arr(arr)
#   left = if arr[0].is_a? Array
#     eval_arr(arr[0])
#   else
#     arr[0]
#   end

#   right = if arr[2].is_a? Array
#     eval_arr(arr[2])
#   else
#     arr[2]
#   end
 
#   if right == 0 && arr[1] == :/
#     Float::INFINITY
#   else
#     left.send(arr[1], right)
#   end
# end

# def twenty_four_fast(a, b, c, d)
#   all_operations = [:+, :/, :*, :-].repeated_permutation(3).to_a
#   all_values = [a, b, c, d].map(&:to_r).permutation.to_a

#   all_values.product(all_operations).flat_map do |values, operations|
#     v1, v2, v3, v4 = values 
#     op1, op2, op3 = operations

#     left_tree = values[0].send(operations[0], values[1])
#                         .send(operations[1], values[2])
#                         .send(operations[2], values[3]) rescue 0
#     left_right_tree = values[0].send(operations[0], values[1].send(operations[1], values[2]))
#                               .send(operations[2], values[3]) rescue 0
#     balanced_tree = values[0].send(operations[0], values[1])
#                             .send(operations[1], values[2].send(operations[2], values[3])) rescue 0
#     right_left_tree = values[0].send(
#                         operations[0], 
#                         values[1].send(operations[1], values[2])
#                                 .send(operations[2], values[3])
#                       ) rescue 0
#     right_tree = values[0].send(
#                   operations[0], 
#                   values[1].send(operations[1], values[2].send(operations[2], values[3]))
#                 ) rescue 0

#     if [left_tree, left_right_tree, balanced_tree, right_left_tree, right_tree].any? { |value| value == 24}
#       return true
#     end
#   end

#   return false
# end

puts twenty_four(3, 8, 3, 8).inspect