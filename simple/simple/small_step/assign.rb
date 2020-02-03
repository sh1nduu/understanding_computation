# frozen_string_literal: true

module Simple
  class Assign
    include Reducible
    reduce_to [].class

    def reduce(environment)
      if expression.reducible?
        [self.class.new(name, expression.reduce(environment)), environment]
      else
        [DoNothing.new, environment.merge(name => expression)]
      end
    end
  end
end
