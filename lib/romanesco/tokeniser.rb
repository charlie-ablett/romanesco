require_relative './token'

module Romanesco
  class Tokeniser

    TOKEN_TYPES = [
        {name: 'addition', regex: /^\+/, token_class: AdditionToken},
        {name: 'multiplication', regex: /^\*/, token_class: MultiplicationToken},
        {name: 'subtraction', regex: /^\-/, token_class: SubtractionToken},
        {name: 'division', regex: /^\//, token_class: DivisionToken},
        {name: 'open parenthesis', regex: /^\(/, token_class: OpenParenthesisToken},
        {name: 'close parenthesis', regex: /^\)/, token_class: CloseParenthesisToken},
        {name: 'constant', regex: /^[0-9]*\.?[0-9]+/, token_class: ConstantToken},
        {name: 'string', regex: /^[a-zA-Z_]+/, token_class: VariableToken}
    ]

    def tokenise(raw_expression)
      expression = remove_commas_and_whitespace(raw_expression)

      tokens = []

      while expression.length > 0
        token_count = tokens.count
        TOKEN_TYPES.each do |type|
          if expression =~ type[:regex]
            token_string = expression.slice!(type[:regex])
            tokens << type[:token_class].send(:new, token_string)
          end
        end

        raise InvalidExpressionError.new("Expression error starting at #{expression}") if tokens.size == token_count
      end

      tokens
    end

    private

    def remove_commas_and_whitespace(raw_expression)
      raise InvalidExpressionError if raw_expression.match(/[a-zA-Z_]\s+[a-zA-Z_]/)
      raw_expression.gsub(/\s+/, '').gsub(',', '')
    end
  end
end