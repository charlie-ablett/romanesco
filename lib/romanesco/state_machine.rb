require 'romanesco/token'

module Romanesco

  class ExpressionState

    class << self
      def next_state(token)
        state = @states[token.state_machine_class]
        return state if state
        raise InvalidExpressionError
      end

      def finish_here
        @finishing_state = true
      end

      def transitions(value)
        @states = value
      end

      def transition(tree, tokens)
        if tokens.empty?
          raise InvalidExpressionError unless @finishing_state
          return tree
        end
        current_token = tokens.shift
        tree.add(current_token.element.new(current_token.expression_part)) unless current_token.is_a? CloseParenthesisToken
        tree.close_parenthesis if current_token.is_a? CloseParenthesisToken
        next_state = next_state(current_token)
        classify(next_state).transition(tree, tokens)
      end

      private

      def classify(string)
        Object.const_get("Romanesco::#{string}")
      end
    end
  end

  class StateZero < ExpressionState
    transitions({ OperandToken => 'StateOne',
        OpenParenthesisToken => 'StateZero' })
  end

  class StateOne < ExpressionState
    transitions({ OperatorToken => 'StateTwo',
      CloseParenthesisToken => 'StateOne' })

    finish_here
  end

  class StateTwo < ExpressionState
    transitions({ OperandToken => 'StateThree',
        OpenParenthesisToken => 'StateZero' })
  end

  class StateThree < ExpressionState
    transitions({ OperatorToken => 'StateTwo',
      CloseParenthesisToken => 'StateOne'})

    finish_here
  end
end