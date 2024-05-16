module Logic
  class LogicOperation
    attr_reader :operand1
    attr_reader :operand2

    def initialize(operand1, operand2)
      @operand1 = operand1
      @operand2 = operand2
    end
  end

  class And < LogicOperation
    def traverse(visitor, payload)
      visitor.visit_andl(self, payload)
    end
  end

  class Or < LogicOperation
    def traverse(visitor, payload)
      visitor.visit_orl(self, payload)
    end
  end

  # This class doesn't inherit since it only takes in one argument
  class Not
    attr_reader :operand

    def initialize(operand)
      @operand = operand
    end

    def traverse(visitor, payload)
      visitor.visit_notl(self, payload)
    end
  end
end