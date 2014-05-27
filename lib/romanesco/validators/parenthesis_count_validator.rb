require 'romanesco/validators/validator'

module Romanesco
  module Validators
    class ParenthesisCountValidator < Validator

      def validate(raw_expression)
        open_parenthesis = /(\()/
        close_parenthesis = /(\))/

        open_parenthesis_count = raw_expression.scan(open_parenthesis).size
        close_parenthesis_count = raw_expression.scan(close_parenthesis).size

        raise InvalidExpressionError.new('Uneven number of parentheses') unless open_parenthesis_count == close_parenthesis_count

        raw_expression
      end
    end
  end
end