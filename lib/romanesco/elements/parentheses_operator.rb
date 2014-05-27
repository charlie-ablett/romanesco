require 'romanesco/elements/unary_operator'

module Romanesco
  class ParenthesesOperator < UnaryOperator

    def initialize(symbol)
      @symbol = '()'
    end

    def precedence
      @precedence || 100
    end

  end
end