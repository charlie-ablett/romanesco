require 'romanesco/elements/operand'

module Romanesco
  class ConstantOperand < Operand

    attr_accessor :value

    def initialize(value)
      @value = value.to_f
    end

    def evaluate(options)
      @value
    end

    def to_s
      @value.to_s
    end

  end
end