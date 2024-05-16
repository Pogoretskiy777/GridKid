require_relative 'serializer.rb'

module Primitive 

  class NumericPrimitive
    attr_reader :value

    def initialize(value)
      @value = value
    end
  end

  class IntegerPrimitive < NumericPrimitive
    def traverse(visitor, payload)
      visitor.visit_integer(self, payload)   # Method refers itself
    end
  end

  class FloatPrimitive < NumericPrimitive
    def traverse(visitor, payload)
      visitor.visit_float(self, payload)   # Method refers itself
    end
  end

  class Boolean
    attr_reader :bool

    def initialize(bool)
      @bool = bool
    end

    def traverse(visitor, payload)
      visitor.visit_boolean(self, payload)
    end
  end

  class String
    attr_reader :chars

    def initialize(chars)
      @chars = chars
    end

    def size
      @chars.size
    end

    def traverse(visitor, payload)
      visitor.visit_string(self, payload)
    end
  end

  class CellAddress
    attr_reader :col
    attr_reader :row

    def initialize(col, row)
      @col = col
      @row = row
    end

    def traverse(visitor, payload)
      visitor.visit_cell_addr(self, payload)
    end
  end

end
