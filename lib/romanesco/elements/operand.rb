require 'romanesco/elements/expression'

module Romanesco
  class Operand < Expression

    def connect(last_operator, last_operand)
      if last_operator && last_operator.is_a?(BinaryOperator) && last_operator.left_operand
        last_operator.insert_element_to_right(self)
      elsif last_operator
        last_operator.insert_element_to_right(self)
      end
    end

  end
end