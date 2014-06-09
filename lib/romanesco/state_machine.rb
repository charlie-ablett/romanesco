require 'romanesco/token'

module Romanesco

  class ExpressionState

    def self.valid_finishing_state?
      raise NotImplementedError
    end

    def self.next_state(token)
      raise NotImplementedError
    end

    def self.transition(tree, tokens)
      if tokens.empty?
        raise InvalidExpressionError unless valid_finishing_state?
        return tree
      end
      current_token = tokens.shift
      tree.add(current_token.element.new(current_token.expression_part)) unless current_token.is_a? CloseParenthesisToken
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