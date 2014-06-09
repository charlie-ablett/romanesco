require 'romanesco/elements/binary_operator'

module Romanesco
  class AdditionOperator < BinaryOperator

    def initialize(symbol)
      @symbol = '+'
    end

    def evaluate(options={})
      left_result, right_result = super(options)
      left_result + right_result
    end

    def default_precedence
      10
    end

  end
end