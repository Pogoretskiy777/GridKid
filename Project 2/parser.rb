require_relative '../Project 1/cast.rb'
require_relative '../Project 1/bitwise.rb'
require_relative '../Project 1/relational.rb'
require_relative '../Project 1/logical.rb'
require_relative '../Project 1/cell_values.rb'
require_relative '../Project 1/grid.rb'
require_relative '../Project 1/functions.rb'

class Parser 

  def initialize(tokens)
    @tokens = tokens
    @i = 0
  end

  def has(type)
    @i< @tokens.size && @tokens[@i].type == type
  end

  # Checks if the inputed token is somewhere in the list of tokens
  def has_ahead(token)
    is_ahead = false
    (@i...@tokens.size).each do |i|
      if @tokens[i].type == token
        is_ahead = true
        break 
      end
    end
    is_ahead
  end

  def advance
    @i += 1
    @tokens[@i - 1]   # Return token that you have moved past
  end

  def parse 
    expression
  end
  
  def primary
    if has(:integer_literal)
      previous = advance
      return Primitive::IntegerPrimitive.new(previous.token.to_i)
    elsif has(:float_literal)
      previous = advance
      return Primitive::FloatPrimitive.new(previous.token.to_f)
    elsif has(:true)
      previous = advance
      return Primitive::Boolean.new(true)
    elsif has(:false)
      previous = advance
      return Primitive::Boolean.new(false)
    elsif has(:string)
      previous = advance
      # Check for invalid functions
      if has(:left_bracket) || has(:left_parenthesis)
        return "\"#{previous.token}\" is not a valid function: \nSupported functions: MIN, MAX, MEAN, SUM"
      else
        return Primitive::String.new(previous.token.to_s)
      end
    elsif has(:max)
      previous = advance
      # Check for valid parenthesis
      if !has(:left_parenthesis)
        return "Incorrect syntax: Expected a left parenthesis after token index #{previous.start_i} (#{@tokens[@i].type})"
      else
        # Check if the parenthesis is enclosed. Primary calls to lvalue ensure correct number of parentheses types
        if !has_ahead(:right_parenthesis)
          return "Incorrect syntax: Expected a closing right parenthesis some point after #{previous.start_i} (#{@tokens[@i].type})"
        else
          advance
          # Call for first lvalue
          left_addr = primary
          if has(:comma)
            advance
            # Call for second lvalue
            right_addr = primary
          else
            return "Incorrect syntax: Expected a comma-separated pair of cell locations."
          end
          advance
          return Functions::Max.new(left_addr, right_addr)
        end
      end
    elsif has(:min)
      previous = advance
      # Check for valid parenthesis
      if !has(:left_parenthesis)
        return "Incorrect syntax: Expected a left parenthesis after token index #{previous.start_i} (#{@tokens[@i].type})"
      else
        # Check if the parenthesis is enclosed. Primary calls to lvalue ensure correct number of parentheses types
        if !has_ahead(:right_parenthesis)
          return "Incorrect syntax: Expected a closing right parenthesis some point after #{previous.start_i} (#{@tokens[@i].type})"
        else
          advance
          # Call for first lvalue
          left_addr = primary
          if has(:comma)
            advance
            # Call for second lvalue
            right_addr = primary
          else
            return "Incorrect syntax: Expected a comma-separated pair of cell locations."
          end
          advance
          return Functions::Min.new(left_addr, right_addr)
        end
      end
    elsif has(:sum)
      previous = advance
      # Check for valid parenthesis
      if !has(:left_parenthesis)
        return "Incorrect syntax: Expected a left parenthesis after token index #{previous.start_i} (#{@tokens[@i].type})"
      else
        # Check if the parenthesis is enclosed. Primary calls to lvalue ensure correct number of parentheses types
        if !has_ahead(:right_parenthesis)
          return "Incorrect syntax: Expected a closing right parenthesis some point after #{previous.start_i} (#{@tokens[@i].type})"
        else
          advance
          # Call for first lvalue
          left_addr = primary
          if has(:comma)
            advance
            # Call for second lvalue
            right_addr = primary
          else
            return "Incorrect syntax: Expected a comma-separated pair of cell locations."
          end
          advance
          return Functions::Sum.new(left_addr, right_addr)
        end
      end
    elsif has(:mean)
      previous = advance
      # Check for valid parenthesis
      if !has(:left_parenthesis)
        return "Incorrect syntax: Expected a left parenthesis after token index #{previous.start_i} (#{@tokens[@i].type})"
      else
        # Check if the parenthesis is enclosed. Primary calls to lvalue ensure correct number of parentheses types
        if !has_ahead(:right_parenthesis)
          return "Incorrect syntax: Expected a closing right parenthesis some point after #{previous.start_i} (#{@tokens[@i].type})"
        else
          advance
          # Call for first lvalue
          left_addr = primary
          if has(:comma)
            advance
            # Call for second lvalue
            right_addr = primary
          else
            return "Incorrect syntax: Expected a comma-separated pair of cell locations."
          end
          advance
          return Functions::Mean.new(left_addr, right_addr)
        end
      end
    elsif has (:float_cast)
      previous = advance
      if !has(:left_parenthesis)
        return "Incorrect syntax: Expected a left parenthesis after float after token index #{previous.start_i} (#{@tokens[@i].type})"
      else
        new_tokens = []
        num_of_r_parenthesis = 0;
        num_of_l_parenthesis = 1;
        advance
        # Ensure that all parentheses are properly enclosed
        while (num_of_r_parenthesis != num_of_l_parenthesis  && (@i < @tokens.size))
          if has(:left_parenthesis) 
            num_of_l_parenthesis += 1
          elsif has(:right_parenthesis)
            num_of_r_parenthesis += 1
            if (num_of_l_parenthesis == num_of_r_parenthesis)
              break
            end
          end
          new_tokens.push(@tokens[@i])
          advance
        end
        advance
        parser = Parser.new(new_tokens).parse
        return Casts::IntToFloat.new(parser)
      end
    elsif has (:int_cast)
      previous = advance
      if !has(:left_parenthesis)
        return "Incorrect syntax: Expected a left parenthesis after float after token index #{previous.start_i} (#{@tokens[@i].type})"
      else
        new_tokens = []
        num_of_r_parenthesis = 0;
        num_of_l_parenthesis = 1;
        advance
        # Ensure that all parentheses are properly enclosed
        while ((num_of_r_parenthesis != num_of_l_parenthesis) && (@i < @tokens.size))
          if has(:left_parenthesis) 
            num_of_l_parenthesis += 1
          elsif has(:right_parenthesis)
            num_of_r_parenthesis += 1
            if (num_of_l_parenthesis == num_of_r_parenthesis)
              break
            end
          end
          new_tokens.push(@tokens[@i])
          advance
        end
        advance
        parser = Parser.new(new_tokens).parse
        return Casts::FloatToInt.new(parser)
      end
    elsif has(:left_parenthesis)
      if !has_ahead(:right_parenthesis)
        return "Incorrect syntax: Expected a closing parenthesis after token index #{@tokens[@i].start_i} (#{@tokens[@i].type})"
      else
        new_tokens = []
        num_of_r_parenthesis = 0;
        num_of_l_parenthesis = 1;
        advance
        # Ensure that all parentheses are properly enclosed
        while ((num_of_r_parenthesis != num_of_l_parenthesis) && (@i < @tokens.size))
          if has(:left_parenthesis) 
            num_of_l_parenthesis += 1
          elsif has(:right_parenthesis)
            num_of_r_parenthesis += 1
            if (num_of_l_parenthesis == num_of_r_parenthesis)
              break
            end
          end
          new_tokens.push(@tokens[@i])
          advance
        end
        if (num_of_l_parenthesis != num_of_r_parenthesis)
          return "Invalid syntax: All parentheses should be validly enclosed"
        end
        advance
        return parser = Parser.new(new_tokens).parse
      end
    elsif has(:hash)
      previous = advance
      # Check for proper bracketing
      if !has(:left_bracket)
        return "Incorrect syntax: Expected a left bracket after # after token index #{@tokens[@i].start_i} (#{@tokens[@i].type})"
      else
        # Check to see if bracket is properly closed
        if !has_ahead(:right_bracket)
          return "Incorrect syntax: Expected a closing right bracket some point after token index #{previous.start_i} (#{@tokens[@i].type})"
        else
          if !has_ahead(:comma)
            return "Incorrect syntax: Expected comma-separated values"
          else
            new_tokens = []
            advance
            while (!has(:comma))
              new_tokens.push(@tokens[@i])
              advance
            end
            advance
            parser_left = Parser.new(new_tokens).parse
            new_tokens.clear
            while (!has(:right_bracket))
              new_tokens.push(@tokens[@i])
              advance
            end
            advance
            parser_right = Parser.new(new_tokens).parse
            return Cells::CellRValue.new(parser_left, parser_right)
          end
        end
      end
    elsif has(:left_bracket)
      previous = advance
      if !has_ahead(:right_bracket)
        return "Incorrect syntax: Expected a closing right bracket some point after token index #{@tokens[@i].start_i} (#{@tokens[@i].type})"
      else
        if !has_ahead(:comma)
          return "Incorrect syntax: Expected comma-separated values"
        else
          new_tokens = []
          while (!has(:comma))
            new_tokens.push(@tokens[@i])
            advance
          end
          advance
          parser_left = Parser.new(new_tokens).parse
          new_tokens.clear
          while (!has(:right_bracket))
            new_tokens.push(@tokens[@i])
            advance
          end
          advance
          parser_right = Parser.new(new_tokens).parse
          return Cells::CellLValue.new(parser_left, parser_right)
        end
      end
    # Ensure proper bracket and parenthesis order and placement
    elsif has(:right_bracket) || has(:right_parenthesis)
      return "Improper placement of token \"#{@tokens[@i].token}\" at index #{@tokens[@i].start_i}"
    end
  end

  def logical_or
    left = logical_and
    while has(:logical_or)
      if has(:logical_or)
        advance
        left = Logic::Or.new(left, logical_and)
      end
    end
    left
  end

  def logical_and
    left = relational
    while has(:logical_and)
      if has(:logical_and)
        advance
        left = Logic::And.new(left, relational)
      end
    end
    left
  end

  def relational
    left = bit_or_xor
    while has(:less_than) || has(:less_than_or_equal) || has(:more_than) ||has(:more_than_or_equal) || has(:relational_equals) || has(:not_equal)
      if has(:less_than)
        advance
        left = Relation::LessThan.new(left, bit_or_xor)
      elsif has(:less_than_or_equal)
        advance
        left = Relation::LessThanOrEquals.new(left, bit_or_xor)
      elsif has(:more_than)
        advance
        left = Relation::MoreThan.new(left, bit_or_xor)
      elsif has(:more_than_or_equal)
        advance
        left = Relation::MoreThanOrEquals.new(left, bit_or_xor)
      elsif has(:relational_equals)
        advance
        left = Relation::Equals.new(left, bit_or_xor)
      elsif has(:not_equal)
        advance
        left = Relation::NotEquals.new(left, bit_or_xor)
      end
    end
    left
  end

  def bit_or_xor
    left = bit_and
    while has(:xor) || has(:vertical)
      if has(:xor)
        advance
        left = BitWise::Xor.new(left, bit_and)
      elsif has(:vertical)
        advance
        left = BitWise::Or.new(left, bit_and)
      end
    end
    left
  end

  def bit_and
    left = bitshift
    while has(:ampersand)
      if has(:ampersand)
        advance
        left = BitWise::And.new(left, bitshift)
      end
    end
    left
  end

  def bitshift
    left = arithmetic
    while has(:lshift) || has(:rshift)
      if has(:lshift)
        advance
        left = BitWise::LeftShift.new(left, arithmetic)
      elsif has(:rshift)
        advance
        left = BitWise::RightShift.new(left, arithmetic)
      end
    end
    left
  end

  def arithmetic 
    left = multiplicative
    while has(:plus) || has(:hyphen)
      if has(:plus)
        advance
        left = Arithmetic::Add.new(left, multiplicative)
      elsif has(:hyphen)
        advance
        left = Arithmetic::Subtract.new(left, multiplicative)
      end
    end
    left
  end

  def multiplicative
    left = negate
    while has(:asterisk) || has(:expo) || has(:percent) || has(:slash)
      if has(:asterisk)
        advance
        left = Arithmetic::Multiply.new(left, negate)
      elsif has(:percent)
        advance
        left = Arithmetic::Modulo.new(left, negate)
      elsif has(:slash)
        advance
        left = Arithmetic::Divide.new(left, negate)
      end
    end
    left
  end

  def negate
    left = power
    while has(:hyphen) && ((@tokens[@i - 1].type != :integer_literal && @tokens[@i - 1].type != :float_literal) || @i == 0)
      if has(:hyphen)
        advance
        left = Arithmetic::Negate.new(power)
      end
    end
    left
  end

  def power
    left = bit_logical_not
    while has(:expo)
      if has(:expo)
        advance
        left = Arithmetic::Exponentiation.new(left, power)
      end
    end
    left
  end

  def bit_logical_not
    left = primary
    while has(:bitnot) || has(:logical_not)
      if has(:bitnot)
        advance
        left = BitWise::Not.new(primary)
      elsif has(:logical_not)
        advance
        left = Logic::Not.new(primary)
      end
    end
    left
  end

  def expression
    expression = logical_or
  end
end