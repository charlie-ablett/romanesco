require 'romanesco/elements/addition_operator'
require 'romanesco/elements/subtraction_operator'
require 'romanesco/elements/multiplication_operator'
require 'romanesco/elements/division_operator'
require 'romanesco/elements/parentheses_operator'
require 'romanesco/elements/variable_operand'
require 'romanesco/elements/constant_operand'
require 'romanesco/token'

module Romanesco

  TOKEN_TYPES = [
      {name: 'addition', regex: /^\+/, token_class: AdditionToken},
      {name: 'multiplication', regex: /^\*/, token_class: MultiplicationToken},
      {name: 'subtraction', regex: /^\-/, token_class: SubtractionToken},
      {name: 'division', regex: /^\//, token_class: DivisionToken},
      {name: 'open parenthesis', regex: /^\(/, token_class: OpenParenthesisToken},
      {name: 'close parenthesis', regex: /^\)/, token_class: CloseParenthesisToken},
      {name: 'constant', regex: /^[0-9]*\.?[0-9]+/, token_class: ConstantToken},
      {name: 'variable', regex: /^[a-zA-Z_]+/, token_class: VariableToken}
  ]

  class ExpressionState

    def self.valid_finishing_state?
      raise NotImplementedError
    end

    def self.next_state(token)
      raise NotImplementedError
    end

    def self.token_to_element(token)
      return AdditionOperator if token.is_a? AdditionToken
      return SubtractionOperator if token.is_a? SubtractionToken
      return MultiplicationOperator if token.is_a? MultiplicationToken
      return DivisionOperator if token.is_a? DivisionToken
      return ParenthesesOperator if token.is_a?(OpenParenthesisToken)
      return ConstantOperand if token.is_a? ConstantToken
      return VariableOperand if token.is_a? VariableToken
      raise InvalidExpressionError
    end

    def self.transition(tree, tokens)
      if tokens.empty?
        raise InvalidExpressionError unless valid_finishing_state?
        return tree
      end
      current_token = tokens.shift
      tree.add(token_to_element(current_token).new(current_token.expression_part)) unless current_token.is_a? CloseParenthesisToken
      tree.close_parenthesis if current_token.is_a? CloseParenthesisToken
      next_state = next_state(current_token)
      next_state.transition(tree, tokens)
    end
  end

  class StateZero < ExpressionState

    def self.next_state(token)
      case token
        when OperandToken
          return StateOne
        when OpenParenthesisToken
          return StateZero
        else
          raise InvalidExpressionError
      end
    end

    def self.valid_finishing_state?
      false
    end

  end

  class StateOne < ExpressionState

    def self.next_state(token)
      case token
        when OperatorToken
          return StateTwo
        when CloseParenthesisToken
          return StateOne
        else
          raise InvalidExpressionError
      end
    end

    def self.valid_finishing_state?
      true
    end
  end

  class StateTwo < ExpressionState

    def self.next_state(token)
      case token
        when OperandToken
          return StateThree
        when OpenParenthesisToken
          return StateZero
        else
          raise InvalidExpressionError
      end
    end

    def self.valid_finishing_state?
      false
    end
  end

  class StateThree < ExpressionState

    def self.next_state(token)
      case token
        when OperatorToken
          return StateTwo
        when CloseParenthesisToken
          return StateOne
        else
          raise InvalidExpressionError
      end
    end

    def self.valid_finishing_state?
      true
    end
  end
end