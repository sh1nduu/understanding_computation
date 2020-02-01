# frozen_string_literal: true

module Simple
  module SmallStep
    class Machine
      attr_accessor :expression, :environment
      def initialize(expression, environment)
        @expression = expression
        @environment = environment
      end

      def step
        @expression = @expression.reduce(@environment)
      end

      def run
        step while @expression.reducible?
        @expression
      end
    end
  end
end
