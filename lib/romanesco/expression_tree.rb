module Romanesco
  class ExpressionTree
    attr_accessor :last_operand, :last_operator, :original_expression

    def initialize(expression)
      @original_expression = expression
    end

    def add(element)
      if element.is_a? Operand
        insert_operand(element)
      elsif element.is_a? Operator
        insert_operator(element)
      end
    end

    def close_parenthesis
      current_node = @last_operand

      until current_node.is_a? ParenthesesOperator
        current_node = current_node.parent
      end

      current_node.precedence = 0

      @last_operand = current_node.parent || current_node
      @last_operator = current_node.parent || current_node
    end

    def evaluate(options={})
      starting_point.evaluate(options)
    end

    def to_s
      starting_point.to_s
    end

    private

    def starting_point
      current_node = @last_operand
      until current_node.parent.nil?
        current_node = current_node.parent
      end
      current_node
    end

    def insert_operand(operand)
      if @last_operator
        if @last_operator.is_a? BinaryOperator
          @last_operator.right_operand = operand
        elsif @last_operator.is_a? UnaryOperator
          @last_operator.operand = operand
        end
        operand.parent = @last_operator
      end

      @last_operand = operand
    end

    def insert_operator(operator)
      if @last_operator && @last_operator.is_a?(ParenthesesOperator) && @last_operator.precedence > operator.precedence
        insert_operator_in_place(operator)
      elsif @last_operator && @last_operator.is_a?(ParenthesesOperator) && @last_operator.precedence < operator.precedence
        insert_operator_up_tree(operator)
      elsif @last_operator && @last_operator.precedence >= operator.precedence
        insert_operator_up_tree(operator)
      elsif @last_operator
        insert_operator_in_place(operator)
      else
        insert_operator_to_left(operator)
      end

      @last_operator = operator
    end

    def insert_operator_in_place(operator)
      operator.left_operand = @last_operand if operator.is_a? BinaryOperator
      operator.operand = @last_operand if operator.is_a? UnaryOperator
      @last_operand.parent = operator

      @last_operator.right_operand = operator if @last_operator.is_a? BinaryOperator
      @last_operator.operand = operator if @last_operator.is_a? UnaryOperator

      operator.parent = @last_operator
    end

    def insert_operator_up_tree(operator)
      operator.left_operand = @last_operator if operator.is_a? BinaryOperator
      operator.operand = @last_operator if operator.is_a? UnaryOperator

      @last_operator.parent = operator
    end

    def insert_operator_to_left(operator)
      operator.left_operand = @last_operand if operator.is_a? BinaryOperator
      operator.operand = @last_operand if operator.is_a? UnaryOperator

      @last_operand.parent = operator if @last_operand
    end
  end
end