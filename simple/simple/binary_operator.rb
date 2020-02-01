# frozen_string_literal: true

module Simple
  class BinaryOp < Node
    include SmallStep::Reducible
    include SmallStep::BinaryOperator

    class << self
      attr_accessor :operator

      def use_symbol(operator)
        self.operator = operator
      end
    end

    attr_accessor :left, :right
    def initialize(left, right)
      self.left = left
      self.right = right
    end

    def ==(other)
      left == other.left && right == other.right && super(other)
    end

    def to_s
      "#{left} #{self.class.operator} #{right}"
    end
  end
end
