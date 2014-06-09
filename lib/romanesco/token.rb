require 'romanesco/elements/addition_operator'
require 'romanesco/elements/subtraction_operator'
require 'romanesco/elements/multiplication_operator'
require 'romanesco/elements/division_operator'
require 'romanesco/elements/parentheses_operator'
require 'romanesco/elements/variable_operand'
require 'romanesco/elements/constant_operand'

module Romanesco

  class Token

    attr_accessor :expression_part

    def initialize(string)
      @expression_part = string
    end

    def element
      raise NotImplementedError
    end
  end

  class OperatorToken < Token
  end

  class MultiplicationToken < OperatorToken
    def element
      MultiplicationOperator
    end
  end

  class DivisionToken < OperatorToken
    def element
      DivisionOperator
    end
  end

  class AdditionToken < OperatorToken
    def element
      AdditionOperator
    end
  end

  class SubtractionToken < OperatorToken
    def element
      SubtractionOperator
    end
  end


  class OperandToken < Token
  end

  class VariableToken < OperandToken
    def element
      VariableOperand
    end
  end

  class ConstantToken < OperandToken
    def element
      ConstantOperand
    end
  end


  class OpenParenthesisToken < Token
    def element
      ParenthesesOperator
    end
  end

  class CloseParenthesisToken < Token
  end

end