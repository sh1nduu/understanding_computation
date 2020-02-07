# frozen_string_literal: true

module Simple
  class Variable
    def evaluate(environment)
      environment[name]
    end
  end
end
