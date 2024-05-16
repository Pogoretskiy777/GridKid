module Cells
  class CellValue
    attr_reader :row
    attr_reader :col
  
    def initialize(row, col)
      @row = row
      @col = col 
    end
  end

  class CellLValue < CellValue
    def traverse(visitor, payload)
      visitor.visit_lvalue(self, payload)
    end
  end

  class CellRValue < CellValue
    def traverse(visitor, payload)
      visitor.visit_rvalue(self, payload)
    end
  end
end