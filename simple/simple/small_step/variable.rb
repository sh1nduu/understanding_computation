# frozen_string_literal: true

module Simple
  module SmallStep
    module Variable
      def reduce(environment)
        environment.fetch(name)
      rescue KeyError
        raise "Undefined variable #{name}"
      end
    end
  end
end
