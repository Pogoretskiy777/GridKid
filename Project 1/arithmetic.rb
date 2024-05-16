module Arithmetic 

  class NumericExpression
    attr_reader :operand1
    attr_reader :operand2

    def initialize(operand1, operand2)
      @operand1 = operand1
      @operand2 = operand2
    end
  end

  class Add < NumericExpression
    def traverse(visitor, payload)
      visitor.visit_add(self, payload)
    end
  end

  class Subtract < NumericExpression
    def traverse(visitor, payload)
      visitor.visit_subtract(self, payload)
    end
  end

  class Multiply < NumericExpression
    def traverse(visitor, payload)
      visitor.visit_multiplication(self, payload)
    end
  end

  class Divide < NumericExpression
    def traverse(visitor, payload)
      visitor.visit_division(self, payload)
    end
  end

  class Modulo < NumericExpression
    def traverse(visitor, payload)
      visitor.visit_modulo(self, payload)
    end
  end

  class Exponentiation < NumericExpression
    def traverse(visitor, payload)
      visitor.visit_expo(self, payload)
    end
  end

  # This class doesn't inherit since it only takes in one argument
  class Negate
    attr_reader :operand

    def initialize(operand)
      @operand = operand
    end

    def traverse(visitor, payload)
      visitor.visit_negate(self, payload)
    end
  end
end
