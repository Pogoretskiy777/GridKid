module Casts
  class Cast
    attr_reader :operand

    def initialize(operand)
      @operand = operand
    end
  end

  class FloatToInt < Cast
    def traverse(visitor, payload)
      visitor.visit_f_to_i(self, payload)
    end
  end

  class IntToFloat < Cast
    def traverse(visitor, payload)
      visitor.visit_i_to_f(self, payload)
    end
  end
end