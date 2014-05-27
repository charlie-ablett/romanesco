require 'romanesco/version'
require 'romanesco/parser'

module Romanesco
  class Romanesco
    def self.parse(raw_expression)
      parser = Parser.new
      parser.parse(raw_expression)
    end
  end
end
