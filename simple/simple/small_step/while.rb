# frozen_string_literal: true

module Simple
  class While
    include Reducible
    reduce_to [].class
    def reduce(environment)
      [If.new(condition, Sequence.new(body, self), DoNothing.new), environment]
    end
  end
end
