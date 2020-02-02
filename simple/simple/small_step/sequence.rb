# frozen_string_literal: true

module Simple
  module SmallStep
    module Sequence
      def reduce(environment)
        case first
        when DoNothing.new
          [second, environment]
        else
          reduced_first, reduced_environment = first.reduce(environment)
          [self.class.new(reduced_first, second), reduced_environment]
        end
      end
    end
  end
end
