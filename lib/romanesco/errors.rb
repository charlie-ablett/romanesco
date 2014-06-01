module Romanesco

  class NoSymbolError < StandardError; end
  class InvalidExpressionError < StandardError; end

  class MissingVariables < StandardError
    attr_accessor :missing_variables

    def initialize(message = nil, missing_variables = nil)
      super(message)
      self.missing_variables = missing_variables
    end
  end


  class HasInfiniteLoopError < StandardError; end

end