# frozen_string_literal: true

module Simple
  class BinaryOperator
    def evaluate(environment)
      reduced_class.new(
        left.evaluate(environment)
            .value
            .public_send(
              self.class.operator,
              right.evaluate(environment).value
            )
      )
    end
  end
end
