require 'romanesco/elements/binary_operator'

module Romanesco
  class MultiplicationOperator < BinaryOperator

    def initialize(symbol)
      @symbol = '*'
    end

    def evaluate(options)
      super(options)
      @left_result * @right_result
    end

    def precedence
      @precedence || 50
    end

  end
end