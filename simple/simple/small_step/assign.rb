# frozen_string_literal: true

module Simple
  module SmallStep
    module Assign
      def reduce(environment)
        if expression.reducible?
          [self.class.new(name, expression.reduce(environment)), environment]
        else
          [DoNothing.new, environment.merge(name => expression)]
        end
      end
    end
  end
end
