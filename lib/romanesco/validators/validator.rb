module Romanesco
  module Validators
    class Validator

      attr_accessor :next_step

      def initialize(next_step=nil)
        @next_step = next_step
      end

      def execute(object)
        modified_object = validate(object)
        return modified_object if next_step.nil?
        next_step.execute(modified_object)
      end

      def validate(object)
        raise NotImplementedError
      end
    end
  end
end