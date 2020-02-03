# frozen_string_literal: true

module Simple
  class Variable
    include Reducible
    reduce_to Value

    def reduce(environment)
      environment.fetch(name)
    rescue KeyError
      raise "Undefined variable #{name}"
    end
  end
end
