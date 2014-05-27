module Romanesco
  class Expression

    attr_accessor :parent

    def initialize(expression_part)
      @expression_part = expression_part
    end

    def evaluate(options)
      raise NotImplementedError
    end

  end
end