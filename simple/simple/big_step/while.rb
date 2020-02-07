# frozen_string_literal: true

module Simple
  class While
    def evaluate(environment)
      case condition.evaluate(environment)
      when Boolean.new(true)
        evaluate(body.evaluate(environment))
      when Boolean.new(false)
        environment
      end
    end
  end
end
