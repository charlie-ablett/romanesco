require 'romanesco/elements/expression'

module Romanesco
  class Operator < Expression

    attr_accessor :symbol

    def evaluate(options)
      raise NotImplementedError
    end

    def precedence
      @precedence || default_precedence
    end

    def check_for_blank_symbol
      raise NoSymbolError if @symbol.nil? || @symbol.gsub(/\s+/, '').empty?
    end

    def precedence=(value)
      @precedence = value
    end

    def default_precedence
      raise NotImplementedError
    end

  end
end