# frozen_string_literal: true

module Simple
  class Sequence
    def evaluate(environment)
      second.evaluate(first.evaluate(environment))
    end
  end
end
