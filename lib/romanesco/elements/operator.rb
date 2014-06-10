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

    def connect_in_place(last_operator, last_operand)
      self.insert_element_to_left(last_operand)
      last_operator.insert_element_to_right(self)
    end

    def connect_up_tree(last_operator)
      self.insert_element_to_left(last_operator)
    end

    def connect_to_left(last_operand)
      self.insert_element_to_left(last_operand)
    end

  end
end