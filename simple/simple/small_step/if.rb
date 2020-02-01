# frozen_string_literal: true

module Simple
  module SmallStep
    module If
      def reduce(environment)
        if condition.reducible?
          [self.class.new(condition, consequence, alternative), environment]
        else
          case condition
          when Boolean.new(true)
            [consequence, environment]
          when Boolean.new(false)
            [alternative, environment]
          end
        end
      end
    end
  end
end
