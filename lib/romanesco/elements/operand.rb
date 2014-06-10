require 'romanesco/elements/expression'

module Romanesco
  class Operand < Expression

    def connect(last_operator, last_operand)
      if last_operator
        last_operator.insert_element_to_right(self) if last_operator
      end
    end

  end
end