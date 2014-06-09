require 'romanesco/elements/operator'

module Romanesco
  class BinaryOperator < Operator

    attr_accessor :left_operand, :right_operand, :symbol

    def initialize(symbol)
      @symbol = symbol
    end

    def evaluate(options)
      check_for_blank_symbol
      left_result = @left_operand.evaluate(options)
      right_result = @right_operand.evaluate(options)
      return left_result, right_result
    end

    def to_s
      "#{@left_operand.to_s} #{symbol} #{@right_operand.to_s}"
    end

    def insert_element_to_left(element)
      @left_operand = element
      element.parent = self if element
    end

    def insert_element_to_right(element)
      @right_operand = element
      element.parent = self if element
    end

  end
end