require_relative 'primitives.rb'
require_relative 'arithmetic.rb'

class Serializer 

  def visit_integer(node, runtime)
    node.value.to_s
  end
  
  def visit_float(node, runtime)
    node.value.to_s
  end
  
  def visit_boolean(node, runtime)
    node.bool.to_s
  end
  
  def visit_string(node, runtime)
    node.chars.to_s
  end

  def visit_cell_addr(node, runtime)
    "[#{node.col}, #{node.row}]"
  end

  def visit_add(node, runtime)
    if node.operand1.is_a?(Primitive::NumericPrimitive) || node.operand2.is_a?(Primitive::NumericPrimitive)
      Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} + #{node.operand2.traverse(Serializer.new(), runtime)}").chars
    else
      Primitive::String.new("(#{node.operand1.traverse(Serializer.new(), runtime)}) + (#{node.operand2.traverse(Serializer.new(), runtime)})").chars
    end
  end

  def visit_subtract(node, runtime)
    if node.operand1.is_a?(Primitive::NumericPrimitive) || node.operand2.is_a?(Primitive::NumericPrimitive)
      Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} - #{node.operand2.traverse(Serializer.new(), runtime)}").chars
    else
      Primitive::String.new("(#{node.operand1.traverse(Serializer.new(), runtime)}) - (#{node.operand2.traverse(Serializer.new(), runtime)})").chars
    end
  end

  def visit_multiplication(node, runtime)
    if node.operand1.is_a?(Primitive::NumericPrimitive) || node.operand2.is_a?(Primitive::NumericPrimitive)
      Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} * #{node.operand2.traverse(Serializer.new(), runtime)}").chars
    else
      Primitive::String.new("(#{node.operand1.traverse(Serializer.new(), runtime)}) * (#{node.operand2.traverse(Serializer.new(), runtime)})").chars
    end
  end

  def visit_division(node, runtime)
    if node.operand1.is_a?(Primitive::NumericPrimitive) || node.operand2.is_a?(Primitive::NumericPrimitive)
      Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} / #{node.operand2.traverse(Serializer.new(), runtime)}").chars
    else
      Primitive::String.new("(#{node.operand1.traverse(Serializer.new(), runtime)}) / (#{node.operand2.traverse(Serializer.new(), runtime)})").chars
    end
  end

  def visit_modulo(node, runtime)
    if node.operand1.is_a?(Primitive::NumericPrimitive) || node.operand2.is_a?(Primitive::NumericPrimitive)
      Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} % #{node.operand2.traverse(Serializer.new(), runtime)}").chars
    else
      Primitive::String.new("(#{node.operand1.traverse(Serializer.new(), runtime)}) % (#{node.operand2.traverse(Serializer.new(), runtime)})").chars
    end
  end

  def visit_expo(node, runtime)
    if node.operand1.is_a?(Primitive::NumericPrimitive) || node.operand2.is_a?(Primitive::NumericPrimitive)
      Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} ^ #{node.operand2.traverse(Serializer.new(), runtime)}").chars
    else
      Primitive::String.new("(#{node.operand1.traverse(Serializer.new(), runtime)}) ^ (#{node.operand2.traverse(Serializer.new(), runtime)})").chars
    end
  end

  def visit_negate(node, runtime)
    if node.operand.is_a?(Primitive::NumericPrimitive)
      Primitive::String.new("!#{node.operand.traverse(Serializer.new(), runtime)}").chars
    else
      Primitive::String.new("!(#{node.operand.traverse(Serializer.new(), runtime)})").chars
    end
  end

  def visit_andl(node, runtime)
    Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} && #{node.operand2.traverse(Serializer.new(), runtime)}").chars
  end

  def visit_orl(node, runtime)
    Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} || #{node.operand2.traverse(Serializer.new(), runtime)}").chars
  end

  def visit_notl(node, runtime)
    Primitive::String.new("!(#{node.operand.traverse(Serializer.new(), runtime)})").chars
  end

  def visit_lvalue(node, runtime)
    Primitive::String.new("[#{node.row.traverse(Serializer.new(), runtime)}, #{node.col.traverse(Serializer.new(), runtime)}]").chars
  end

  def visit_rvalue(node, runtime)
    Primitive::String.new("#[#{node.row.traverse(Serializer.new(), runtime)}, #{node.col.traverse(Serializer.new(), runtime)}]").chars
  end

  def visit_bitand(node, runtime)
    Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} & #{node.operand2.traverse(Serializer.new(), runtime)}").chars
  end

  def visit_bitor(node, runtime)
    Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} | #{node.operand2.traverse(Serializer.new(), runtime)}").chars
  end

  def visit_bitxor(node, runtime)
    Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} ^ #{node.operand2.traverse(Serializer.new(), runtime)}").chars
  end

  def visit_rshift(node, runtime)
    Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} >> #{node.operand2.traverse(Serializer.new(), runtime)}").chars
  end

  def visit_lshift(node, runtime)
    Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} << #{node.operand2.traverse(Serializer.new(), runtime)}").chars
  end

  def visit_bitnot(node, runtime)
    Primitive::String.new("~#{node.operand.traverse(Serializer.new, runtime)}").chars
  end

  def visit_requals(node, runtime)
    Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} == #{node.operand2.traverse(Serializer.new(), runtime)}").chars
  end

  def visit_rnotequals(node, runtime)
    Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} != #{node.operand2.traverse(Serializer.new(), runtime)}").chars
  end

  def visit_less(node, runtime)
    Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} < #{node.operand2.traverse(Serializer.new(), runtime)}").chars
  end

  def visit_less_equals(node, runtime)
    Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} <= #{node.operand2.traverse(Serializer.new(), runtime)}").chars
  end

  def visit_more(node, runtime)
    Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} > #{node.operand2.traverse(Serializer.new(), runtime)}").chars
  end

  def visit_more_equals(node, runtime)
    Primitive::String.new("#{node.operand1.traverse(Serializer.new(), runtime)} >= #{node.operand2.traverse(Serializer.new(), runtime)}").chars
  end

  def visit_f_to_i(node, runtime)
    Primitive::String.new("(float)(#{node.operand.traverse(Serializer.new(), runtime)})").chars
  end

  def visit_i_to_f(node, runtime)
    Primitive::String.new("(int)(#{node.operand.traverse(Serializer.new(), runtime)})").chars
  end

  def visit_sum(node, runtime)
    Primitive::String.new("sum(#{node.lvalue1.traverse(Serializer.new(), runtime)}, #{node.lvalue2.traverse(Serializer.new(), runtime)})").chars
  end

  def visit_mean(node, runtime)
    Primitive::String.new("mean(#{node.lvalue1.traverse(Serializer.new(), runtime)}, #{node.lvalue2.traverse(Serializer.new(), runtime)})").chars
  end

  def visit_max(node, runtime)
    Primitive::String.new("max(#{node.lvalue1.traverse(Serializer.new(), runtime)}, #{node.lvalue2.traverse(Serializer.new(), runtime)})").chars
  end

  def visit_min(node, runtime)
    Primitive::String.new("min(#{node.lvalue1.traverse(Serializer.new(), runtime)}, #{node.lvalue2.traverse(Serializer.new(), runtime)})").chars
  end
end
