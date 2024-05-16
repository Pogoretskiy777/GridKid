require_relative 'primitives.rb'
require_relative 'evaluator.rb'
require_relative 'serializer.rb'
require_relative 'arithmetic.rb'
require_relative 'logical.rb'

# Create a cell to store ASTs
class Cell
  attr_reader :serial
  attr_reader :tree
  attr_reader :evaluation

  def initialize(serial, ast, evaluation)
    @serial = serial
    @ast = ast
    @evaluation = evaluation
  end
end

# Create a grid to store cells
class Grid
  attr_reader :rows
  attr_reader :columns
  attr_reader :grid

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @grid = Array.new(rows) {Array.new(columns)}
  end

  def set_cell(cell_address, ast)
    if cell_address.row < 0 || cell_address.row >= @rows || cell_address.col < 0 || cell_address.col >= @columns
      raise "Invalid cell address. Row: #{cell_address.row} Col: #{cell_address.col}"
    end
    begin
    serial = ast.traverse(Serializer.new, nil)
    evaluation = ast.traverse(Evaluator.new, Runtime.new(self))
    cell = Cell.new(serial, ast, evaluation)
    @grid[cell_address.row][cell_address.col] = cell
    rescue NoMethodError
      return Primitive::String.new("Error: Invalid cell references")
    end
  end

  def get_cell(cell_address)
    cell = @grid[cell_address.row][cell_address.col]
    if cell.nil? || !cell.is_a?(Cell)
      return Primitive::String.new("Error: Invalid syntax")
    else
      cell.evaluation
    end
  end
end

# Create an abstract runtime that references the grid
class Runtime
  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end
end
