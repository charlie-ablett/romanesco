require 'romanesco/expression_tree_builder'
require 'romanesco/validators/parenthesis_count_validator'
require 'romanesco/validators/character_validator'
require 'romanesco/tokeniser'

module Romanesco
  class Parser

    def parse(raw_expression)
      validate_expression(raw_expression)

      tokens = Tokeniser.new.tokenise(raw_expression)

      tree_builder = ExpressionTreeBuilder.new
      tree_builder.build_tree(raw_expression, tokens)
    end

    private

    def validate_expression(raw_expression)
      chain = build_chain([Validators::CharacterValidator, Validators::ParenthesisCountValidator])
      chain.execute(raw_expression)
    end

    def build_chain(classes)
      last = nil
      classes.reverse.each do |klass|
        last = klass.new(last)
      end
      last
    end
  end
end