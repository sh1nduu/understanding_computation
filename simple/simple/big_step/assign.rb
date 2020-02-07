# frozen_string_literal: true

module Simple
  class Assign
    def evaluate(environment)
      environment.merge(name => expression.evaluate(environment))
    end
  end
end
