# frozen_string_literal: true

module Simple
  class Sequence
    include Reducible
    reduce_to [].class

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
