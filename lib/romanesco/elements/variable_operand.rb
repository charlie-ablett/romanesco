require 'romanesco/elements/operand'

module Romanesco

  class VariableOperand < Operand

    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def evaluate(options)
      options[@name.to_sym].to_f
    end

    def to_s
      @name.to_s
    end

  end

end