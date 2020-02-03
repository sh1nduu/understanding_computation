# frozen_string_literal: true

module Simple
  class BinaryOperator
    include Reducible

    def reduce(environment)
      if left.reducible?
        new_instance(left.reduce(environment), right)
      elsif right.reducible?
        new_instance(left, right.reduce(environment))
      else
        operate
      end
    end

    private
    def new_instance(*args)
      self.class.new(*args)
    end

    def operate
      raise "Can't reduce different types" unless left.class == right.class

      reduced_class.new(
        left.value.public_send(self.class.operator, right.value)
      )
    end
  end
end
