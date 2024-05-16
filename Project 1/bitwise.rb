module BitWise
  class BitWiseOperation
    attr_reader :operand1, :operand2

    def initialize(operand1, operand2)
      @operand1 = operand1
      @operand2 = operand2
    end
  end

  class And < BitWiseOperation
    def traverse(visitor, payload)
      visitor.visit_bitand(self, payload)
    end
  end

  class Or < BitWiseOperation
    def traverse(visitor, payload)
      visitor.visit_bitor(self, payload)
    end
  end

  class Xor < BitWiseOperation
    def traverse(visitor, payload)
      visitor.visit_bitxor(self, payload)
    end
  end

  class LeftShift < BitWiseOperation
    def traverse(visitor, payload)
      visitor.visit_lshift(self, payload)
    end
  end

  class RightShift < BitWiseOperation
    def traverse(visitor, payload)
      visitor.visit_rshift(self, payload)
    end
  end

  # This class doesn't inherit since it only takes in one argument
  class Not
    attr_reader :operand

    def initialize(operand)
      @operand = operand
    end

    def traverse(visitor, payload)
      visitor.visit_bitnot(self, payload)
    end
  end
end