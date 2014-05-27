require 'romanesco/validators/validator'

module Romanesco
  module Validators
    class CharacterValidator < Validator

      def validate(raw_expression)
        regex = /^[\w\s\-\*\+\/\(\)\.]*$/

        no_whitespace = raw_expression.gsub(/\s+/, '')
        raise InvalidExpressionError.new('Empty expression') if raw_expression.nil? || no_whitespace.empty?
        raise InvalidExpressionError.new('Illegal characters found') unless regex =~ raw_expression

        raw_expression
      end
    end
  end
end