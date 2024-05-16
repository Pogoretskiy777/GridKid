require_relative 'primitives.rb'
require_relative 'evaluator.rb'
require_relative 'serializer.rb'
require_relative 'arithmetic.rb'
require_relative 'logical.rb'
require_relative 'cell_values.rb'
require_relative 'bitwise.rb'
require_relative 'relational.rb'
require_relative 'cast.rb'

puts "\n"
adding = Arithmetic::Add.new(
  Primitive::IntegerPrimitive.new(4), 
  Primitive::IntegerPrimitive.new(4))
max = adding.traverse(Serializer.new, nil)
puts "Testing adding integers:"
puts "Serialization: " + max
puts "Evaluation: #{adding.traverse(Evaluator.new, nil).value}\n\n"

cell_address = Primitive::CellAddress.new(5, 4)
puts "Testing cell address:"
puts "Serialization: " + cell_address.traverse(Serializer.new(), nil)
puts "Evaluation: #{cell_address.traverse(Evaluator.new, nil)}\n\n"

addingf = Arithmetic::Add.new(
  Primitive::FloatPrimitive.new(4.2), 
  Primitive::FloatPrimitive.new(4.2))
max = addingf.traverse(Serializer.new, nil)
puts "Testing adding floats:"
puts "Serialization: " + max
puts "Evaluation: #{addingf.traverse(Evaluator.new, nil).value}\n\n"

sum_multiple = Arithmetic::Add.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(1), 
    Primitive::IntegerPrimitive.new(2)), 
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(3), 
    Primitive::IntegerPrimitive.new(4)))
puts "Testing adding other additions:"
puts "Serialization: " + sum_multiple.traverse(Serializer.new, nil)
puts "Evaluation: #{sum_multiple.traverse(Evaluator.new, nil).value}\n\n"

multiply_and_subtract = Arithmetic::Multiply.new(
  Arithmetic::Subtract.new(
    Primitive::IntegerPrimitive.new(1), 
    Primitive::IntegerPrimitive.new(2)), 
  Primitive::IntegerPrimitive.new(4))
puts "Testing multiplication:"
puts "Serialization: " + multiply_and_subtract.traverse(Serializer.new, nil)
puts "Evaluation: #{multiply_and_subtract.traverse(Evaluator.new, nil).value}\n\n"

divide_and_add = Arithmetic::Divide.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(1), 
    Primitive::IntegerPrimitive.new(7)), 
  Primitive::IntegerPrimitive.new(4))
puts "Testing division:"
puts "Serialization: " + divide_and_add.traverse(Serializer.new, nil)
puts "Evaluation: #{divide_and_add.traverse(Evaluator.new, nil).value}\n\n"

modulo_and_add = Arithmetic::Modulo.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(1), 
    Primitive::IntegerPrimitive.new(2)),
  Arithmetic::Subtract.new(
    Primitive::IntegerPrimitive.new(8), 
    Primitive::IntegerPrimitive.new(4)))
puts "Testing modulo:"
puts "Serialization: " + modulo_and_add.traverse(Serializer.new, nil)
puts "Evaluator: #{modulo_and_add.traverse(Evaluator.new, nil).value}\n\n"

expo_and_add = Arithmetic::Exponentiation.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(1), 
    Primitive::IntegerPrimitive.new(2)), 
  Arithmetic::Subtract.new(
    Primitive::IntegerPrimitive.new(8), 
    Primitive::IntegerPrimitive.new(4)))
puts "Testing exponentiation:"
puts "Serialization: " + expo_and_add.traverse(Serializer.new, nil)
puts "Evaluator: #{expo_and_add.traverse(Evaluator.new, nil).value}\n\n"

negate_primitive = Arithmetic::Negate.new(
  Primitive::IntegerPrimitive.new(8))
puts "Testing primitivenegation:"
puts "Serialization: " + negate_primitive.traverse(Serializer.new, nil)
puts "Evaluation: #{negate_primitive.traverse(Evaluator.new, nil).value}\n\n"

negate_negate = Arithmetic::Negate.new(
  Arithmetic::Negate.new(
    Primitive::IntegerPrimitive.new(8)))
puts "Testing self-negation:"
puts "Serialization: " + negate_negate.traverse(Serializer.new, nil)
puts "Evaluation: #{negate_negate.traverse(Evaluator.new, nil).value}\n\n"

negate_expression = Arithmetic::Negate.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(8),
    Primitive::IntegerPrimitive.new(-4))
)
puts "Testing negating expressions:"
puts "Serialization: " + negate_expression.traverse(Serializer.new, nil)
puts "Evaluation: #{negate_expression.traverse(Evaluator.new, nil).value}\n\n"

truth_false_and = Logic::And.new(
  Primitive::Boolean.new(true),
  Primitive::Boolean.new(false)
  )
puts "Testing logical and:"
puts "Serializer: " + truth_false_and.traverse(Serializer.new, nil)
puts "Evaluation: #{truth_false_and.traverse(Evaluator.new, nil).bool}\n\n"

truth_false_or = Logic::Or.new(
  Primitive::Boolean.new(true),
  Primitive::Boolean.new(false)
  )
puts "Testing logical or:"
puts "Serializer: " + truth_false_or.traverse(Serializer.new, nil)
puts "Evaluation: #{truth_false_or.traverse(Evaluator.new, nil).bool}\n\n"

truth_truth_false = truth_truth_false = Logic::And.new(
  Logic::And.new(
    Primitive::Boolean.new(true),
    Primitive::Boolean.new(true)
  ),
  Primitive::Boolean.new(false)
  )
puts "Testing logical and with expressions:"
puts "Serializer: " + truth_truth_false.traverse(Serializer.new, nil)
puts "Evaluation: #{truth_truth_false.traverse(Evaluator.new, nil).bool}\n\n"

not_true_or_false = Logic::Or.new(
  Logic::Not.new(
    Primitive::Boolean.new(true)),
  Primitive::Boolean.new(false)
)
puts "Testing logical or with expressions:"
puts "Serializer: " + not_true_or_false.traverse(Serializer.new, nil)
puts "Evaluation: #{not_true_or_false.traverse(Evaluator.new, nil).bool}\n\n"

lvalue = Cells::CellLValue.new(
  Primitive::IntegerPrimitive.new(5),
  Primitive::IntegerPrimitive.new(3))
puts "Testing primitive cell lvalue:"
puts "Serializer: " + lvalue.traverse(Serializer.new, nil)
puts "Evaluation: #{lvalue.traverse(Evaluator.new, nil).traverse(Serializer.new, nil)}\n\n" 

lvalue_expressions = Cells::CellLValue.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(5),
    Primitive::IntegerPrimitive.new(3)),
  Arithmetic::Subtract.new(
    Primitive::IntegerPrimitive.new(9),
    Primitive::IntegerPrimitive.new(3)
  ))
puts "Testing expressive cell lvalue:"
puts "Serializer: " + lvalue_expressions.traverse(Serializer.new, nil)
puts "Evaluation: #{lvalue_expressions.traverse(Evaluator.new, nil).traverse(Serializer.new, nil)}\n\n" 

bitwise_and = BitWise::And.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(5),
    Primitive::IntegerPrimitive.new(3)),
  Arithmetic::Subtract.new(
    Primitive::IntegerPrimitive.new(9),
    Primitive::IntegerPrimitive.new(3)
  ))
puts "Testing bitwise and operation:"
puts "Serializer: " + bitwise_and.traverse(Serializer.new, nil)
puts "Evaluator: #{bitwise_and.traverse(Evaluator.new, nil).traverse(Serializer.new, nil)}\n\n"

bitwise_or = BitWise::Or.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(5),
    Primitive::IntegerPrimitive.new(3)),
  Arithmetic::Subtract.new(
    Primitive::IntegerPrimitive.new(9),
    Primitive::IntegerPrimitive.new(3)
  ))
puts "Testing bitwise or operation:"
puts "Serializer: " + bitwise_or.traverse(Serializer.new, nil)
puts "Evaluator: #{bitwise_or.traverse(Evaluator.new, nil).traverse(Serializer.new, nil)}\n\n"

bitwise_xor = BitWise::Xor.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(20),
    Primitive::IntegerPrimitive.new(3)),
  Arithmetic::Subtract.new(
    Primitive::IntegerPrimitive.new(9),
    Primitive::IntegerPrimitive.new(3)
  ))
puts "Testing bitwise xor operation:"
puts "Serializer: " + bitwise_xor.traverse(Serializer.new, nil)
puts "Evaluator: #{bitwise_xor.traverse(Evaluator.new, nil).traverse(Serializer.new, nil)}\n\n"

bitwise_lshift = BitWise::LeftShift.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(20),
    Primitive::IntegerPrimitive.new(3)),
  Arithmetic::Subtract.new(
    Primitive::IntegerPrimitive.new(9),
    Primitive::IntegerPrimitive.new(3)
  ))
puts "Testing bitwise left shift operation:"
puts "Serializer: " + bitwise_lshift.traverse(Serializer.new, nil)
puts "Evaluator: #{bitwise_lshift.traverse(Evaluator.new, nil).traverse(Serializer.new, nil)}\n\n" 

bitwise_rshift = BitWise::RightShift.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(20),
    Primitive::IntegerPrimitive.new(3)),
  Arithmetic::Subtract.new(
    Primitive::IntegerPrimitive.new(9),
    Primitive::IntegerPrimitive.new(3)
  ))
puts "Testing bitwise left shift operation:"
puts "Serializer: " + bitwise_rshift.traverse(Serializer.new, nil)
puts "Evaluator: #{bitwise_rshift.traverse(Evaluator.new, nil).traverse(Serializer.new, nil)}\n\n" 

bitwise_not = BitWise::Not.new(
  BitWise::Not.new(
    Arithmetic::Add.new(
      Primitive::IntegerPrimitive.new(3),
      Primitive::IntegerPrimitive.new(4)
    )))
puts "Testing bitwise not operation:"
puts "Serializer: " + bitwise_not.traverse(Serializer.new, nil)
puts "Evaluator: #{bitwise_not.traverse(Evaluator.new, nil).traverse(Serializer.new, nil)}\n\n"

equality = Relation::Equals.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(20),
    Primitive::IntegerPrimitive.new(3)),
  Arithmetic::Subtract.new(
    Primitive::IntegerPrimitive.new(30),
    Primitive::IntegerPrimitive.new(7)
  ))
puts "Testing equality:"
puts "Serializer: " + equality.traverse(Serializer.new, nil)
puts "Evaluator: #{equality.traverse(Evaluator.new, nil).bool}\n\n"

equality_string = Relation::Equals.new(
  Primitive::String.new("Hello"),
  Primitive::String.new("Hello"))
puts "Testing equality with strings:"
puts "Serializer: " + equality_string.traverse(Serializer.new, nil)
puts "Evaluator: #{equality_string.traverse(Evaluator.new, nil).bool}\n\n"

equality_cell_address = Relation::Equals.new(
  Primitive::CellAddress.new(4, 5),
  Primitive::CellAddress.new(6, 5))
puts "Testing equality with cell addresses:"
puts "Serializer: " + equality_cell_address.traverse(Serializer.new, nil)
puts "Evaluator: #{equality_cell_address.traverse(Evaluator.new, nil).bool}\n\n"

not_equality = Relation::NotEquals.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(20),
    Primitive::IntegerPrimitive.new(3)),
  Arithmetic::Subtract.new(
    Primitive::IntegerPrimitive.new(30),
    Primitive::IntegerPrimitive.new(7)
  ))
puts "Testing equality:"
puts "Serializer: " + not_equality.traverse(Serializer.new, nil)
puts "Evaluator: #{not_equality.traverse(Evaluator.new, nil).bool}\n\n"

less = Relation::LessThan.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(20),
    Primitive::IntegerPrimitive.new(3)),
  Arithmetic::Subtract.new(
    Primitive::IntegerPrimitive.new(40),
    Primitive::IntegerPrimitive.new(9)
  ))
puts "Testing less than operation:"
puts "Serializer: " + less.traverse(Serializer.new, nil)
puts "Evaluator: #{less.traverse(Evaluator.new, nil).bool}\n\n"

less_equals = Relation::LessThanOrEquals.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(20),
    Primitive::IntegerPrimitive.new(3)),
  Arithmetic::Subtract.new(
    Primitive::IntegerPrimitive.new(40),
    Primitive::IntegerPrimitive.new(17)
  ))
puts "Testing less than or equals operation:"
puts "Serializer: " + less_equals.traverse(Serializer.new, nil)
puts "Evaluator: #{less_equals.traverse(Evaluator.new, nil).bool}\n\n"

more = Relation::MoreThan.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(20),
    Primitive::IntegerPrimitive.new(3)),
  Arithmetic::Subtract.new(
    Primitive::IntegerPrimitive.new(40),
    Primitive::IntegerPrimitive.new(9)
  ))
puts "Testing more than operation:"
puts "Serializer: " + more.traverse(Serializer.new, nil)
puts "Evaluator: #{more.traverse(Evaluator.new, nil).bool}\n\n"

more_equals = Relation::MoreThanOrEquals.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(20),
    Primitive::IntegerPrimitive.new(3)),
  Arithmetic::Subtract.new(
    Primitive::IntegerPrimitive.new(40),
    Primitive::IntegerPrimitive.new(17)
  ))
puts "Testing more than or equals operation:"
puts "Serializer: " + more_equals.traverse(Serializer.new, nil)
puts "Evaluator: #{more_equals.traverse(Evaluator.new, nil).bool}\n\n"

float_to_int = Casts::FloatToInt.new(
  Arithmetic::Add.new(
    Primitive::FloatPrimitive.new(3.6),
    Primitive::FloatPrimitive.new(3.6)
  ))
puts "Testing float-to-int cast:"
puts "Serializer: " + float_to_int.traverse(Serializer.new, nil)
puts "Evaluator: #{float_to_int.traverse(Evaluator.new, nil).value}\n\n"

int_to_float = Casts::IntToFloat.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(5),
    Primitive::IntegerPrimitive.new(6)
  ))
puts "Testing int-to-float cast:"
puts "Serializer: " + int_to_float.traverse(Serializer.new, nil)
puts "Evaluator: #{int_to_float.traverse(Evaluator.new, nil).value}\n\n"