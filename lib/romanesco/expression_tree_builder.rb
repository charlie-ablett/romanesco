require 'romanesco/state_machine'
require 'romanesco/expression_tree'

module Romanesco
  class ExpressionTreeBuilder

    def build_tree(expression, elements)
      first_state = StateZero
      new_tree = ExpressionTree.new(expression)
      first_state.transition(new_tree, elements)
      new_tree
    end

  end
end