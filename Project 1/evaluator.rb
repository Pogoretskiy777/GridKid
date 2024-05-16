require_relative 'primitives.rb'

class Evaluator

  def visit_integer(node, runtime)
    node
  end

  def visit_float(node, runtime)
    node
  end

  def visit_boolean(node, runtime)
    node
  end

  def visit_string(node, runtime)
    node
  end

  def visit_cell_addr(node, runtime)
    node
  end

  def visit_add(node, runtime)
    begin
    op1 = node.operand1.traverse(self, runtime)
    op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::IntegerPrimitive) && op2.is_a?(Primitive::IntegerPrimitive))
        Primitive::IntegerPrimitive.new(op1.value + op2.value)
      elsif (op1.is_a?(Primitive::String) && op2.is_a?(Primitive::String))
        Primitive::String.new(op1.chars + op2.chars)
      elsif (op1.is_a?(Primitive::FloatPrimitive) || op2.is_a?(Primitive::FloatPrimitive)) || (op1.is_a?(Primitive::IntegerPrimitive) || op2.is_a?(Primitive::FloatPrimitive)) || (op1.is_a?(Primitive::FloatPrimitive) || op2.is_a?(Primitive::IntegerPrimitive))
        Primitive::FloatPrimitive.new(op1.value + op2.value)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_subtract(node, runtime)
    begin
      op1 = node.operand1.traverse(self, runtime)
      op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::IntegerPrimitive) && op2.is_a?(Primitive::IntegerPrimitive))
        Primitive::IntegerPrimitive.new(op1.value - op2.value)
      elsif (op1.is_a?(Primitive::FloatPrimitive) || op2.is_a?(Primitive::FloatPrimitive)) || (op1.is_a?(Primitive::IntegerPrimitive) || op2.is_a?(Primitive::FloatPrimitive)) || (op1.is_a?(Primitive::FloatPrimitive) || op2.is_a?(Primitive::IntegerPrimitive))
        Primitive::FloatPrimitive.new(op1.value - op2.value)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_multiplication(node, runtime)
    begin
      op1 = node.operand1.traverse(self, runtime)
      op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::IntegerPrimitive) && op2.is_a?(Primitive::IntegerPrimitive))
        Primitive::IntegerPrimitive.new(op1.value * op2.value)
      elsif (op1.is_a?(Primitive::FloatPrimitive) || op2.is_a?(Primitive::FloatPrimitive)) || (op1.is_a?(Primitive::IntegerPrimitive) || op2.is_a?(Primitive::FloatPrimitive)) || (op1.is_a?(Primitive::FloatPrimitive) || op2.is_a?(Primitive::IntegerPrimitive))
        Primitive::FloatPrimitive.new(op1.value * op2.value)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_division(node, runtime)
    begin
      op1 = node.operand1.traverse(self, runtime)
      op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::IntegerPrimitive) && op2.is_a?(Primitive::IntegerPrimitive))
        Primitive::IntegerPrimitive.new(op1.value / op2.value)
      elsif (op1.is_a?(Primitive::FloatPrimitive) || op2.is_a?(Primitive::FloatPrimitive)) || (op1.is_a?(Primitive::IntegerPrimitive) || op2.is_a?(Primitive::FloatPrimitive)) || (op1.is_a?(Primitive::FloatPrimitive) || op2.is_a?(Primitive::IntegerPrimitive))
        Primitive::FloatPrimitive.new(op1.value / op2.value)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_modulo(node, runtime)
    begin
      op1 = node.operand1.traverse(self, runtime)
      op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::IntegerPrimitive) && op2.is_a?(Primitive::IntegerPrimitive))
        Primitive::IntegerPrimitive.new(op1.value % op2.value)
      elsif (op1.is_a?(Primitive::FloatPrimitive) || op2.is_a?(Primitive::FloatPrimitive)) || (op1.is_a?(Primitive::IntegerPrimitive) || op2.is_a?(Primitive::FloatPrimitive)) || (op1.is_a?(Primitive::FloatPrimitive) || op2.is_a?(Primitive::IntegerPrimitive))
        Primitive::FloatPrimitive.new(op1.value % op2.value)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_expo(node, runtime)
    begin
      op1 = node.operand1.traverse(self, runtime)
      op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::IntegerPrimitive) && op2.is_a?(Primitive::IntegerPrimitive))
        Primitive::IntegerPrimitive.new(op1.value ** op2.value)
      elsif (op1.is_a?(Primitive::FloatPrimitive) || op2.is_a?(Primitive::FloatPrimitive))
        Primitive::FloatPrimitive.new(op1.value ** op2.value)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_negate(node, runtime)
    begin
      op = node.operand.traverse(self, runtime)
      if op.is_a?(Primitive::IntegerPrimitive)
        Primitive::IntegerPrimitive.new(-op.value)
      elsif op.is_a?(Primitive::FloatPrimitive)
        Primitive::FloatPrimitive.new(-op.value)
      else 
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_andl(node, runtime)
    begin
      op1 = node.operand1.traverse(self, runtime)
      op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::Boolean) && op2.is_a?(Primitive::Boolean))
        Primitive::Boolean.new(op1.bool && op2.bool)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_orl(node, runtime)
    begin
      op1 = node.operand1.traverse(self, runtime)
      op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::Boolean) && op2.is_a?(Primitive::Boolean))
        Primitive::Boolean.new(op1.bool || op2.bool)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_notl(node, runtime)
    begin
      op = node.operand.traverse(self, runtime)
      if op.is_a?(Primitive::Boolean)
        if op.bool
          Primitive::Boolean.new(false)
        else
          Primitive::Boolean.new(true)
        end
      else 
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_lvalue(node, runtime)
    begin
      row = node.row.traverse(self, runtime)
      col = node.col.traverse(self, runtime)
      if row.is_a?(Primitive::IntegerPrimitive) && col.is_a?(Primitive::IntegerPrimitive)
        Primitive::CellAddress.new(row.value, col.value)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_rvalue(node, runtime)
    begin
      row = node.row.traverse(self, runtime)
      col = node.col.traverse(self, runtime)
      if row.is_a?(Primitive::IntegerPrimitive) && col.is_a?(Primitive::IntegerPrimitive)
        cell_address = Primitive::CellAddress.new(row.value, col.value)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
      runtime.grid.get_cell(cell_address)
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_bitand(node, runtime)
    begin
      op1 = node.operand1.traverse(self, runtime)
      op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::IntegerPrimitive) && op2.is_a?(Primitive::IntegerPrimitive))
        Primitive::IntegerPrimitive.new(op1.value & op2.value)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_bitor(node, runtime)
    begin
      op1 = node.operand1.traverse(self, runtime)
      op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::IntegerPrimitive) && op2.is_a?(Primitive::IntegerPrimitive))
        Primitive::IntegerPrimitive.new(op1.value | op2.value)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_bitxor(node, runtime)
    begin
      op1 = node.operand1.traverse(self, runtime)
      op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::IntegerPrimitive) && op2.is_a?(Primitive::IntegerPrimitive))
        Primitive::IntegerPrimitive.new(op1.value ^ op2.value)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_lshift(node, runtime)
    begin
      op1 = node.operand1.traverse(self, runtime)
      op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::IntegerPrimitive) && op2.is_a?(Primitive::IntegerPrimitive))
        Primitive::IntegerPrimitive.new(op1.value << op2.value)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_rshift(node, runtime)
    begin
      op1 = node.operand1.traverse(self, runtime)
      op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::IntegerPrimitive) && op2.is_a?(Primitive::IntegerPrimitive))
        Primitive::IntegerPrimitive.new(op1.value >> op2.value)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_bitnot(node, runtime)
    begin
      op = node.operand.traverse(self, runtime)
      if op.is_a?(Primitive::IntegerPrimitive)
        Primitive::IntegerPrimitive.new(~op.value)
      else 
        return Primitive::String.new("Error: Cannot match type")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match type")
    end
  end

  def visit_requals(node, runtime)
    begin
      op1 = node.operand1.traverse(self, runtime)
      op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::NumericPrimitive) && op2.is_a?(Primitive::NumericPrimitive))
        Primitive::Boolean.new(op1.value == op2.value)
      elsif (op1.is_a?(Primitive::String) && op2.is_a?(Primitive::String))
        Primitive::Boolean.new(op1.chars == op2.chars)
      elsif (op1.is_a?(Primitive::CellAddress) && op2.is_a?(Primitive::CellAddress))
        Primitive::Boolean.new(op1.traverse(Serializer.new, runtime) == op2.traverse(Serializer.new, runtime))
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_rnotequals(node, runtime)
    begin
      op1 = node.operand1.traverse(self, runtime)
      op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::NumericPrimitive) && op2.is_a?(Primitive::NumericPrimitive))
        Primitive::Boolean.new(op1.value != op2.value)
      elsif (op1.is_a?(Primitive::String) && op2.is_a?(Primitive::String))
        Primitive::Boolean.new(op1.chars != op2.chars)
      elsif (op1.is_a?(Primitive::CellAddress) && op2.is_a?(Primitive::CellAddress))
        Primitive::Boolean.new(op1.traverse(Serializer.new, runtime) != op2.traverse(Serializer.new, runtime))
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_less(node, runtime)
    begin
      op1 = node.operand1.traverse(self, runtime)
      op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::NumericPrimitive) && op2.is_a?(Primitive::NumericPrimitive))
        Primitive::Boolean.new(op1.value < op2.value)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_less_equals(node, runtime)
    begin
      op1 = node.operand1.traverse(self, runtime)
      op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::NumericPrimitive) && op2.is_a?(Primitive::NumericPrimitive))
        Primitive::Boolean.new(op1.value <= op2.value)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_more(node, runtime)
    begin
      op1 = node.operand1.traverse(self, runtime)
      op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::NumericPrimitive) && op2.is_a?(Primitive::NumericPrimitive))
        Primitive::Boolean.new(op1.value > op2.value)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_more_equals(node, runtime)
    begin
      op1 = node.operand1.traverse(self, runtime)
      op2 = node.operand2.traverse(self, runtime)
      if (op1.is_a?(Primitive::NumericPrimitive) && op2.is_a?(Primitive::NumericPrimitive))
        Primitive::Boolean.new(op1.value >= op2.value)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_f_to_i(node, runtime)
    begin
      op = node.operand.traverse(self, runtime)
      if op.is_a?(Primitive::FloatPrimitive)
        Primitive::IntegerPrimitive.new(op.value.to_i)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_i_to_f(node, runtime)
    begin
      op = node.operand.traverse(self, runtime)
      if op.is_a?(Primitive::IntegerPrimitive)
        Primitive::FloatPrimitive.new(op.value.to_f)
      else
        return Primitive::String.new("Error: Cannot match types")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Cannot match types")
    end
  end

  def visit_max(node, runtime)
    begin
      cell1 = node.lvalue1.traverse(self, runtime)
      cell2 = node.lvalue2.traverse(self, runtime)
  
      if cell1.is_a?(Primitive::CellAddress) && cell2.is_a?(Primitive::CellAddress)

        if (cell1.row > cell2.row || cell1.col > cell2.col) || (cell1.row > runtime.grid.rows || cell2.row > runtime.grid.rows || cell1.col > runtime.grid.columns || cell2.col> runtime.grid.columns)
          return Primitive::String.new("Error: Invalid cell references")
        else
          max_value = nil
          (cell1.col..cell2.col).each do |row|
            (cell1.row..cell2.row).each do |col|
              cell_value = Cells::CellRValue.new(
                Primitive::IntegerPrimitive.new(row),
                Primitive::IntegerPrimitive.new(col)
              ).traverse(Evaluator.new, runtime)
              if cell_value.is_a?(Primitive::NumericPrimitive)
                if max_value.nil? || cell_value.value > max_value.value
                  max_value = cell_value
                end
              end
            end
          end
        end
        if max_value.is_a?(Primitive::IntegerPrimitive)
          Primitive::IntegerPrimitive.new(max_value).value
        else
          Primitive::FloatPrimitive.new(max_value).value
        end
      else
        return Primitive::String.new("Error: Invalid cell references")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Invalid cell references")
    end
  end

  def visit_sum(node, runtime)
    begin
      cell1 = node.lvalue1.traverse(self, runtime)
      cell2 = node.lvalue2.traverse(self, runtime)
  
      if cell1.is_a?(Primitive::CellAddress) && cell2.is_a?(Primitive::CellAddress)

        if (cell1.row > cell2.row || cell1.col > cell2.col) || (cell1.row > runtime.grid.rows || cell2.row > runtime.grid.rows || cell1.col > runtime.grid.columns || cell2.col> runtime.grid.columns)
          return Primitive::String.new("Error: Invalid cell references")
        else
          sum = 0
          (cell1.col..cell2.col).each do |row|
            (cell1.row..cell2.row).each do |col|
              cell_value = Cells::CellRValue.new(
                Primitive::IntegerPrimitive.new(row),
                Primitive::IntegerPrimitive.new(col)
              ).traverse(Evaluator.new, runtime)
              if cell_value.is_a?(Primitive::NumericPrimitive)
                sum += cell_value.value
              end
            end
          end
        end
        if sum.is_a?(Integer)
          Primitive::IntegerPrimitive.new(sum)
        else
          Primitive::FloatPrimitive.new(sum)
        end
      else
        return Primitive::String.new("Error: Invalid cell references")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Invalid cell references")
    end
  end

  def visit_min(node, runtime)
    begin
      cell1 = node.lvalue1.traverse(self, runtime)
      cell2 = node.lvalue2.traverse(self, runtime)
  
      if cell1.is_a?(Primitive::CellAddress) && cell2.is_a?(Primitive::CellAddress)

        if (cell1.row > cell2.row || cell1.col > cell2.col) || (cell1.row > runtime.grid.rows || cell2.row > runtime.grid.rows || cell1.col > runtime.grid.columns || cell2.col> runtime.grid.columns)
          return Primitive::String.new("Error: Invalid cell references")
        else
          min_value = nil
          (cell1.col..cell2.col).each do |row|
            (cell1.row..cell2.row).each do |col|
              cell_value = Cells::CellRValue.new(
                Primitive::IntegerPrimitive.new(row),
                Primitive::IntegerPrimitive.new(col)
              ).traverse(Evaluator.new, runtime)
              if cell_value.is_a?(Primitive::NumericPrimitive)
                if min_value.nil? || cell_value.value < min_value.value
                  min_value = cell_value
                end
              end
            end
          end
        end
        if min_value.is_a?(Primitive::IntegerPrimitive)
          Primitive::IntegerPrimitive.new(min_value).value
        else
          Primitive::FloatPrimitive.new(min_value).value
        end
      else
        return Primitive::String.new("Error: Invalid cell references")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Invalid cell references")
    end
  end

  def visit_mean(node, runtime)
    begin
      cell1 = node.lvalue1.traverse(self, runtime)
      cell2 = node.lvalue2.traverse(self, runtime)
  
      if cell1.is_a?(Primitive::CellAddress) && cell2.is_a?(Primitive::CellAddress)

        if (cell1.row > cell2.row || cell1.col > cell2.col) || (cell1.row > runtime.grid.rows || cell2.row > runtime.grid.rows || cell1.col > runtime.grid.columns || cell2.col> runtime.grid.columns)
          return Primitive::String.new("Error: Invalid cell references")
        else
          sum = 0
          counter = 0
          (cell1.col..cell2.col).each do |row|
            (cell1.row..cell2.row).each do |col|
              cell_value = Cells::CellRValue.new(
                Primitive::IntegerPrimitive.new(row),
                Primitive::IntegerPrimitive.new(col)
              ).traverse(Evaluator.new, runtime)
              if cell_value.is_a?(Primitive::NumericPrimitive)
                counter += 1
                sum += cell_value.value
              end
            end
          end
        end
        if counter == 0
          return Primitive::IntegerPrimitive.new(0)
        end
          Primitive::FloatPrimitive.new(sum / counter)
      else
        return Primitive::String.new("Error: Invalid cell references")
      end
    rescue NoMethodError
      return Primitive::String.new("Error: Invalid cell references")
    end
  end
end