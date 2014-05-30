module Romanesco

  class NoSymbolError < StandardError; end
  class InvalidExpressionError < StandardError; end

  class MissingVariableValue < StandardError
    attr_accessor :missing_exceptions

    def initialize(message = nil, missing_exceptions = nil)
      super(message)
      self.missing_exceptions = missing_exceptions
    end
  end


  class HasInfiniteLoopError < StandardError; end

end