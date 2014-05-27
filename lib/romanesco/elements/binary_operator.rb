require 'romanesco/elements/operator'

module Romanesco
  class BinaryOperator < Operator

    attr_accessor :left_operand, :right_operand, :symbol

    def initialize(symbol)
      @symbol = symbol
    end

    def evaluate(options)
      check_for_blank_symbol
      @left_result = @left_operand.evaluate(options)
      @right_result = @right_operand.evaluate(options)
    end

    def to_s
      "#{@left_operand.to_s} #{symbol} #{@right_operand.to_s}"
    end

  end
end