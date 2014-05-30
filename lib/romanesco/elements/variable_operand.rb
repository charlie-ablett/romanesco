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
      raise MissingVariableValue.new("Missing the variable injection '#{@name}'") if element.nil?
      return element.evaluate(options) if element.respond_to?(:evaluate)
      options[@name.to_sym].to_f if element.is_a? Numeric
    end

    def to_s
      @name.to_s
    end

  end

end