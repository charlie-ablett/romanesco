require 'romanesco/version'
require 'romanesco/parser'

module Romanesco
  extend self

  def self.parse(raw_expression)
    parser = Parser.new
    parser.parse(raw_expression)
  end

end
