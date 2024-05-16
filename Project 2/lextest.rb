require_relative 'lexer.rb'
require_relative 'parser.rb'
require_relative '../Project 1/primitives.rb'
require_relative '../Project 1/evaluator.rb'
require_relative '../Project 1/serializer.rb'

# Setup

# Create a new grid 20x20
gridkid = Grid.new(20, 20)

arithmetic = Arithmetic::Multiply.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(4), 
    Primitive::IntegerPrimitive.new(3)), 
  Primitive::IntegerPrimitive.new(7))
modulo = Arithmetic::Modulo.new(
  arithmetic, Primitive::IntegerPrimitive.new(12)
)

gridkid.set_cell(Primitive::CellAddress.new(0, 0), Primitive::FloatPrimitive.new(20.0))
gridkid.set_cell(Primitive::CellAddress.new(0, 1), Primitive::IntegerPrimitive.new(12))
gridkid.set_cell(Primitive::CellAddress.new(1, 2), Primitive::IntegerPrimitive.new(8))
gridkid.set_cell(Primitive::CellAddress.new(2, 2), Primitive::FloatPrimitive.new(8.5))
gridkid.set_cell(Primitive::CellAddress.new(2, 3), modulo)
gridkid.set_cell(Primitive::CellAddress.new(3, 2), Primitive::Boolean.new(true))
gridkid.set_cell(Primitive::CellAddress.new(5, 3), Primitive::IntegerPrimitive.new(4))

# Testing the lexer

relational = "-32.0"

arithmetic = "(5 + 2) * 3 % 4"

rvalue_shift = "#[0, 0] + 3"

rvalue_comp = "#[1 - 1, 0] < #[1 * 1, 1]"

logic_comp = "(5 > 3) && !(2 > 8)"

sum = "1 + sum([0, 0], [2, 1])"

casting = "float(10 + 4) / 4.0"

subtraction = "-(5 - 3) + (2 * 8)"

string = "hello + world"

test_expressions = [relational, arithmetic, rvalue_shift, rvalue_comp, logic_comp, sum, casting, subtraction, string]

# Testing the lexer
test_expressions.each do |expression|
  puts "Testing: #{expression}"
  lexer = Lexer.new(expression)
  tokens = lexer.lex
  tokens.each do |token|
  p token
  end
  puts "\n"
end

# Testing the parser
puts "Testing parsers\n"
test = 'sum([0, 0], [2, 1 + 3]) + 1'
test_expressions.each do |expression|
  lexer = Lexer.new(expression)
  tokens = lexer.lex
  print "Testing the following tokens:   "
  tokens.each do |token|
    print token.token + " "
  end
    puts "\n"
  parser = Parser.new(tokens)
  tree = parser.parse
  print "Evaluated tree:                 "
  p tree.traverse(Evaluator.new, Runtime.new(gridkid))
  puts "\n"
end

# Testing malformed code

# bad_sum = 'sum(3, 4)'
# lexer = Lexer.new(bad_sum)
# tokens = lexer.lex
# parser = Parser.new(tokens)
# tree = parser.parse
# tree.traverse(Evaluator.new, Runtime.new(gridkid))

# bad_parentheses = '((4 - 2) * (3'
# lexer = Lexer.new(bad_parentheses)
# tokens = lexer.lex
# parser = Parser.new(tokens)
# tree = parser.parse
# tree.traverse(Evaluator.new, Runtime.new(gridkid))

# bad_rvalue = '4 + #[3, 3'
# lexer = Lexer.new(bad_rvalue)
# tokens = lexer.lex
# parser = Parser.new(tokens)
# tree = parser.parse
# tree.traverse(Evaluator.new, Runtime.new(gridkid))

# bad_cast = '2 - float[3 - 4]'
# lexer = Lexer.new(bad_cast)
# tokens = lexer.lex
# parser = Parser.new(tokens)
# tree = parser.parse
# tree.traverse(Evaluator.new, Runtime.new(gridkid))

# bad_function = 'bloop([3, 4], [3, 4])'
# lexer = Lexer.new(bad_function)
# tokens = lexer.lex
# parser = Parser.new(tokens)
# tree = parser.parse
# p tree.traverse(Evaluator.new, Runtime.new(gridkid))

# bad_close = '-)8 ** 2'
# lexer = Lexer.new(bad_close)
# tokens = lexer.lex
# parser = Parser.new(tokens)
# tree = parser.parse
# p tree.traverse(Evaluator.new, Runtime.new(gridkid))