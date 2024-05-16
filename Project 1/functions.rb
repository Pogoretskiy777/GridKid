module Functions
  class Function
    attr_reader :lvalue1
    attr_reader :lvalue2

    def initialize(lvalue1, lvalue2)
      @lvalue1 = lvalue1
      @lvalue2 = lvalue2
    end
  end

  class Max < Function
    def traverse(visitor, payload)
      visitor.visit_max(self, payload)
    end
  end

  class Min < Function
    def traverse(visitor, payload)
      visitor.visit_min(self, payload)
    end
  end

  class Mean < Function
    def traverse(visitor, payload)
      visitor.visit_mean(self, payload)
    end
  end

  class Sum < Function
    def traverse(visitor, payload)
      visitor.visit_sum(self, payload)
    end
  end
end