require 'romanesco/errors'

module Romanesco
  class ExpressionTree
    attr_accessor :last_operand, :last_operator, :original_expression
    attr_reader :required_variables

    def initialize(expression)
      @original_expression = expression
      @required_variables = []
    end

    def add(element)
      element.connect(@last_operator, @last_operand)
      @last_operand = element if element.is_a? Operand
      @last_operator = element if element.is_a? Operator

      @required_variables << element.name.to_sym if element.is_a? VariableOperand
    end

    def close_parenthesis
      current_node = @last_operand

      until current_node.is_a? ParenthesesOperator
        current_node = current_node.parent
      end

      current_node.precedence = 0

      @last_operand, @last_operator = current_node.parent || current_node
    end

    def evaluate(options={}, default_value=nil)
      start = starting_point
      check_for_loops(start, options)
      missing_variables, new_options = check_for_missing_variables(start, options, [], default_value)
      raise MissingVariables.new("Missing variables: #{missing_variables.join', '}", missing_variables) unless missing_variables.empty?
      start.evaluate(new_options)
    end

    def to_s
      starting_point.to_s
    end

    def starting_point
      return @starting_point if @starting_point
      current_node = @last_operand
      until current_node.parent.nil?
        current_node = current_node.parent
      end
      @starting_point = current_node
    end

    private

    def check_for_loops(start, options)
      iterate_to_variables(self, start, options) do |node, element, opts, block|
        variable_value = opts[element.name.to_sym]
        if variable_value.respond_to? :starting_point
          raise HasInfiniteLoopError.new('Cannot evaluate - infinite loop detected') if node == variable_value
          iterate_to_variables node, variable_value.starting_point, opts, &block if variable_value.respond_to? :evaluate
        end
      end
    end

    def check_for_missing_variables(start, options, missing_variables, default_value)
      iterate_to_variables(missing_variables, start, options) do |missing_variables, element, opts, block|
        variable_value = opts[element.name.to_sym]
        if variable_value.respond_to? :starting_point
          iterate_to_variables missing_variables, variable_value.starting_point, opts, &block if variable_value.respond_to? :evaluate
        elsif variable_value.nil?
          options[element.name.to_sym] = default_value
          missing_variables << element.name.to_sym unless default_value
        end
      end
      return missing_variables, options
    end

    def iterate_to_variables(node, element, options, &block)
      if element.is_a? BinaryOperator
        iterate_to_variables node, element.left_operand, options, &block
        iterate_to_variables node, element.right_operand, options, &block
      elsif element.is_a? UnaryOperator
        iterate_to_variables node, element.operand, options, &block
      elsif element.is_a? VariableOperand
        block.call(node, element, options, block)
      end
    end

  end
end