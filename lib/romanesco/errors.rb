module Romanesco

  class NoSymbolError < StandardError; end
  class InvalidExpressionError < StandardError; end
  class MissingVariableValue < StandardError; end
  class HasInfiniteLoopError < StandardError; end

end