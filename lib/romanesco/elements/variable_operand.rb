require 'romanesco/elements/operand'
require 'romanesco/errors'

module Romanesco

  class VariableOperand < Operand

    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def evaluate(options)
      element = options[@name.to_sym]
      raise MissingVariableValue.new("Missing the variable injection '#{@name}'. ") if element.nil?
      if element.respond_to?(:evaluate)
        element.evaluate(options)
      else
        options[@name.to_sym].to_f
      end
    end

    def to_s
      @name.to_s
    end

  end

end