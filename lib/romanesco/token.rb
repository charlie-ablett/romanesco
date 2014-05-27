module Romanesco

  class Token

    attr_accessor :expression_part

    def initialize(string)
      @expression_part = string
    end

  end

  class OperatorToken < Token
  end

  class MultiplicationToken < OperatorToken
  end

  class DivisionToken < OperatorToken
  end

  class AdditionToken < OperatorToken
  end

  class SubtractionToken < OperatorToken
  end


  class OperandToken < Token
  end

  class VariableToken < OperandToken
  end

  class ConstantToken < OperandToken
  end


  class OpenParenthesisToken < Token
  end

  class CloseParenthesisToken < Token
  end

end