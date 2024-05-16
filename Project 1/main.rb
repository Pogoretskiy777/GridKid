require_relative 'primitives.rb'
require_relative 'evaluator.rb'
require_relative 'serializer.rb'
require_relative 'arithmetic.rb'
require_relative 'logical.rb'
require_relative 'cell_values.rb'
require_relative 'bitwise.rb'
require_relative 'relational.rb'
require_relative 'cast.rb'
require_relative 'grid.rb'
require_relative 'functions.rb'


# Create a new grid 20x20
gridkid = Grid.new(20, 20)

# Arithmetic: (7 * 4 + 3) % 12
arithmetic = Arithmetic::Multiply.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(4), 
    Primitive::IntegerPrimitive.new(3)), 
  Primitive::IntegerPrimitive.new(7))
modulo = Arithmetic::Modulo.new(
  arithmetic, Primitive::IntegerPrimitive.new(12)
)
puts "Testing arithmetic: (7 * 4 + 3) % 12"
puts modulo.traverse(Serializer.new, nil)
puts modulo.traverse(Evaluator.new, nil).value
puts "\n"

# Testing creating and retrieving a cell
gridkid.set_cell(Primitive::CellAddress.new(2, 4), arithmetic)
primitive = gridkid.get_cell(Primitive::CellAddress.new(2, 4))

# Rvalue lookup and shift: #[1 + 1, 4] << 3
test = Cells::CellRValue.new(
  Arithmetic::Add.new(
    Primitive::IntegerPrimitive.new(1),
    Primitive::IntegerPrimitive.new(1)
  ),
  Primitive::IntegerPrimitive.new(4))
bitshift = BitWise::LeftShift.new(test, Primitive::IntegerPrimitive.new(3))
puts "Testing: #[1 + 1, 4] << 3"
puts bitshift.traverse(Serializer.new, Runtime.new(gridkid))
puts bitshift.traverse(Evaluator.new, Runtime.new(gridkid)).traverse(Serializer.new, nil)
puts "\n\n"

# Rvalue lookup and comparison: #[0, 0] < #[0, 1]
gridkid.set_cell(Primitive::CellAddress.new(0, 0), Primitive::IntegerPrimitive.new(4))
gridkid.set_cell(Primitive::CellAddress.new(0, 1), Primitive::IntegerPrimitive.new(8))
lookup_comparison = Relation::LessThan.new(
  Cells::CellRValue.new(
    Primitive::IntegerPrimitive.new(0),
    Primitive::IntegerPrimitive.new(0),
  ),
  Cells::CellRValue.new(
    Primitive::IntegerPrimitive.new(0),
    Primitive::IntegerPrimitive.new(1),
  )
)
puts "Testing: #[0, 0] < #[0, 1]"
puts lookup_comparison.traverse(Serializer.new, Runtime.new(gridkid))
puts lookup_comparison.traverse(Evaluator.new, Runtime.new(gridkid)).traverse(Serializer.new, nil)
puts "\n\n"

# Logic and comparison: !(3.3 > 3.2)
logic_comp = Logic::Not.new(
  Relation::MoreThan.new(
    Primitive::FloatPrimitive.new(3.3),
    Primitive::FloatPrimitive.new(3.2),
  )
)
puts "Testing: !(3.3 > 3.2)"
puts logic_comp.traverse(Serializer.new, nil)
puts logic_comp.traverse(Evaluator.new, nil).bool
puts "\n\n"

# Casting: float(7) / 2
cast = Arithmetic::Divide.new(
  Casts::IntToFloat.new(
    Primitive::IntegerPrimitive.new(7)
  ),
  Primitive::IntegerPrimitive.new(2)
)
puts "Testing: float(7) / 2"
puts cast.traverse(Serializer.new, nil)
puts cast.traverse(Evaluator.new, nil).value
puts "\n"

# Max: max([1, 2], [5, 3])
gridkid.set_cell(Primitive::CellAddress.new(5, 3), Primitive::IntegerPrimitive.new(4))
gridkid.set_cell(Primitive::CellAddress.new(1, 2), Primitive::IntegerPrimitive.new(8))
gridkid.set_cell(Primitive::CellAddress.new(2, 2), Primitive::FloatPrimitive.new(8.5))
gridkid.set_cell(Primitive::CellAddress.new(2, 3), modulo)
gridkid.set_cell(Primitive::CellAddress.new(3, 2), Primitive::Boolean.new(true))
max = Functions::Max.new(
  Cells::CellLValue.new(
    Primitive::IntegerPrimitive.new(1),
    Primitive::IntegerPrimitive.new(2)
  ),
  Cells::CellLValue.new(
    Primitive::IntegerPrimitive.new(5),
    Primitive::IntegerPrimitive.new(3)
  )
)
puts "Testing: max([1, 2], [5, 3])"
puts max.traverse(Serializer.new, nil)
puts max.traverse(Evaluator.new, Runtime.new(gridkid)).value
puts "\n"

min = Functions::Min.new(
  Cells::CellLValue.new(
    Primitive::IntegerPrimitive.new(1),
    Primitive::IntegerPrimitive.new(2)
  ),
  Cells::CellLValue.new(
    Primitive::IntegerPrimitive.new(5),
    Primitive::IntegerPrimitive.new(3)
  )
)
puts "Testing: min([1, 2], [5, 3])"
puts min.traverse(Serializer.new, nil)
puts min.traverse(Evaluator.new, Runtime.new(gridkid)).value
puts "\n"

# Sum: sum([1, 2], [5, 3])
sum = Functions::Sum.new(
  Cells::CellLValue.new(
    Primitive::IntegerPrimitive.new(1),
    Primitive::IntegerPrimitive.new(2)
  ),
  Cells::CellLValue.new(
    Primitive::IntegerPrimitive.new(5),
    Primitive::IntegerPrimitive.new(3)
  )
)
puts "Testing: sum([1, 2], [5, 3])"
puts sum.traverse(Serializer.new, nil)
puts sum.traverse(Evaluator.new, Runtime.new(gridkid)).value
puts "\n"

# Sum: sum([1, 2], [5, 3])
mean = Functions::Mean.new(
  Cells::CellLValue.new(
    Primitive::IntegerPrimitive.new(1),
    Primitive::IntegerPrimitive.new(2)
  ),
  Cells::CellLValue.new(
    Primitive::IntegerPrimitive.new(5),
    Primitive::IntegerPrimitive.new(3)
  )
)
puts "Testing: mean([1, 2], [5, 3])"
puts mean.traverse(Serializer.new, nil)
puts mean.traverse(Evaluator.new, Runtime.new(gridkid)).value
puts "\n"


hello = Primitive::String.new("Hello")
world = Primitive::String.new(" world!")
concat = Arithmetic::Add.new(hello, world)
puts "Testing: Hello + world!"
puts concat.traverse(Evaluator.new, nil).chars