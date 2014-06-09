require 'romanesco/elements/unary_operator'

module Romanesco
  class ParenthesesOperator < UnaryOperator

    def initialize(symbol)
      @symbol = '()'
    end

    def default_precedence
      100
    end

  end
end