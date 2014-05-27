require 'romanesco/elements/unary_operator'

module Romanesco
  class UnaryMinusOperator < UnaryOperator

    def initialize
      @symbol = '-'
    end

    def evaluate(options)
      super(options)
      -@result
    end

  end
end