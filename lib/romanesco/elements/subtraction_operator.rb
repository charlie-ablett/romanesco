module Romanesco
  class SubtractionOperator < BinaryOperator

    def initialize(symbol)
      @symbol = '-'
    end

    def evaluate(options)
      super(options)
      @left_result - @right_result
    end

    def precedence
      @precedence || 10
    end

  end
end