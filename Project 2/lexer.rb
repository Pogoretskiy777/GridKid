require_relative 'token.rb'

class Lexer
  attr_reader :tokens

  def initialize(source)
    @source = source      # Source code
    @i = 0        # Where you are in the source code
    @tokens = []  # List of tokens collected
    @token_so_far = ''
    @start_i      # Start of the token's index
  end

  def has_letter
    @i < @source.length && (('a' <= @source[@i] && @source[@i] <= 'z'))
  end

  def has_number
    @i < @source.length && '0' <= @source[@i] && @source[@i] <= '9'
  end

  def has(character)
    @i < @source.length && @source[@i] == character
  end

  def capture
    @token_so_far += @source[@i]
    @i += 1
  end

  def skip
    @i += 1
  end

  def abandon
    @token_so_far = ''
    @i += 1
  end

  def emit_token(type)
    @tokens.push(Token.new(type, @token_so_far, @start_i, @start_i + (@token_so_far.length - 1)))
    @token_so_far = ''
  end

  def lex
    while @i < @source.length()
      # Skip white space
      if has(' ')
        skip
      # Check for digits
      elsif has_number
        @start_i = @i
        while has_number
          capture
        end
        # Create integer if there is no following period
        if !has('.')
          emit_token(:integer_literal)
        else
          # Create float if there is a period
          capture
          while has_number
            capture
          end
          emit_token(:float_literal)
        end
      elsif has('[')
        @start_i = @i
        capture
        emit_token(:left_bracket)
      elsif has(']')
        @start_i = @i
        capture
        emit_token(:right_bracket)
      elsif has('(')
        @start_i = @i
        capture
        emit_token(:left_parenthesis)
      elsif has(')')
        @start_i = @i
        capture
        emit_token(:right_parenthesis)
      elsif has('-')
        @start_i = @i
        capture
        emit_token(:hyphen)
      elsif has('+')
        @start_i = @i
        capture
        emit_token(:plus)
      elsif has('*')
        @start_i = @i
        capture
        if has('*')
          capture
          emit_token(:expo)
        else
          emit_token(:asterisk)
        end
      elsif has('/')
        @start_i = @i
        capture
        emit_token(:slash)
      elsif has('^')
        @start_i = @i
        capture
        emit_token(:xor)
      elsif has('~')
        @start_i = @i
        capture
        emit_token(:bitnot)
      elsif has('&')
        @start_i = @i
        capture
        if has('&')
          capture
          emit_token(:logical_and)
        else
          emit_token(:ampersand)
        end
      elsif has('|')
        @start_i = @i
        capture
        if has('|')
          capture
          emit_token(:logical_or)
        else
          emit_token(:vertical)
        end
      elsif has('<')
        @start_i = @i
        capture
        if has('=')
          capture
          emit_token(:less_than_or_equal)
        elsif has('<')
          capture
          emit_token(:lshift)
        else
          emit_token(:less_than)
        end
      elsif has('>')
        @start_i = @i
        capture
        if has('=')
          capture
          emit_token(:more_than_or_equal)
        elsif has('>')
          capture
          emit_token(:rshift)
        else
          emit_token(:more_than)
        end
      elsif has('=')
        @start_i = @i
        capture
        if has('=')
          capture
          emit_token(:relational_equals)
        else
          emit_token(:equals)
        end
      elsif has('#')
        @start_i = @i
        capture
        emit_token(:hash)
      elsif has('!')
        @start_i = @i
        capture
        if has('=')
          capture
          emit_token(:not_equal)
        else
          emit_token(:logical_not)
        end
      elsif has(',')
        @start_i = @i
        capture
        emit_token(:comma)
      elsif has('%')
        @start_i = @i
        capture
        emit_token(:percent)
      elsif has_letter
        @start_i = @i
        capture
        while has_letter
          capture
        end
        if @token_so_far == 'sum' || @token_so_far == 'SUM'
          emit_token(:sum)
        elsif @token_so_far == 'max' || @token_so_far == 'MAX'
          emit_token(:max)
        elsif @token_so_far == 'min' || @token_so_far == 'MIN'
          emit_token(:min)
        elsif @token_so_far == 'mean' || @token_so_far == 'MEAN'
          emit_token(:mean)
        elsif @token_so_far == 'float' || @token_so_far == 'FLOAT'
          emit_token(:float_cast)
        elsif @token_so_far == 'int' || @token_so_far == 'INT'
          emit_token(:int_cast)
        elsif @token_so_far == 'true' || @token_so_far == 'TRUE'
          emit_token(:true)
        elsif @token_so_far == 'false' || @token_so_far == 'FALSE'
          emit_token(:false)
        else
          # Include spaces for non-keyword strings
          while has_letter || has(" ")
            capture
          end
          emit_token(:string)
        end
      else
        abandon
      end
    end
    @tokens
  end
end