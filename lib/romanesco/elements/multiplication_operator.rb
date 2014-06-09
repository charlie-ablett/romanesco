require 'romanesco/elements/binary_operator'

module Romanesco
  class MultiplicationOperator < BinaryOperator

    def initialize(symbol)
      @symbol = '*'
    end

    def evaluate(options)
      left_result, right_result = super(options)
      left_result * right_result
    end

    def default_precedence
      50
    end
  end
end