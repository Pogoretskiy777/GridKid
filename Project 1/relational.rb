module Relation
  class Relational
    attr_reader :operand1
    attr_reader :operand2

    def initialize(operand1, operand2)
      @operand1 = operand1
      @operand2 = operand2
    end
  end

  class Equals < Relational
    def traverse(visitor, payload)
      visitor.visit_requals(self, payload)
    end
  end

  class NotEquals < Relational
    def traverse(visitor, payload)
      visitor.visit_rnotequals(self, payload)
    end
  end

  class LessThan < Relational
    def traverse(visitor, payload)
      visitor.visit_less(self, payload)
    end
  end

  class LessThanOrEquals < Relational
    def traverse(visitor, payload)
      visitor.visit_less_equals(self, payload)
    end
  end

  class MoreThan < Relational
    def traverse(visitor, payload)
      visitor.visit_more(self, payload)
    end
  end

  class MoreThanOrEquals < Relational
    def traverse(visitor, payload)
      visitor.visit_more_equals(self, payload)
    end
  end
end