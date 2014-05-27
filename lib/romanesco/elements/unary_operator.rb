require 'romanesco/elements/operator'

module Romanesco
  class UnaryOperator < Operator

    attr_accessor :operand, :symbol

    def initialize(symbol)
      @symbol = symbol
    end

    def evaluate(options)
      check_for_blank_symbol
      @result = @operand.evaluate(options)
    end

    def to_s
      "(#{@operand.to_s})"
    end

  end
end