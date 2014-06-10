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

    def connect(last_operator, last_operand)
      if last_operator && last_operator.is_a?(ParenthesesOperator) && last_operator.precedence > self.precedence
        connect_in_place(last_operator, last_operand)
      elsif last_operator && last_operator.parent && last_operator.precedence >= self.precedence
        connect_in_place_with_parent(last_operator, last_operand)
      elsif last_operator && last_operator.is_a?(ParenthesesOperator) && last_operator.precedence < self.precedence
        connect_up_tree(last_operator)
      elsif last_operator && last_operator.precedence >= self.precedence
        connect_up_tree(last_operator)
      elsif last_operator && self.is_a?(ParenthesesOperator)
        connect_to_right(last_operator)
      elsif last_operator
        connect_in_place(last_operator, last_operand)
      else
        connect_to_left(last_operand)
      end
    end

    def connect_in_place_with_parent(last_operator, last_operand)
      last_operator.parent.insert_element_to_right(self)
      self.insert_element_to_left(last_operand)
    end

    def connect_in_place(last_operator, last_operand)
      self.insert_element_to_left(last_operand)
      last_operator.insert_element_to_right(self)
    end

    def connect_up_tree(last_operator)
      self.insert_element_to_left(last_operator)
    end

    def connect_to_left(element)
      self.insert_element_to_left(element)
    end

    def connect_to_right(element)
      element.insert_element_to_right(self)
    end
  end
end