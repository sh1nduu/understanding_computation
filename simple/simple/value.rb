# frozen_string_literal: true

module Simple
  class Value < Node
    include SmallStep::Reducible

    attr_accessor :value
    def initialize(value)
      self.value = value
    end

    def ==(other)
      value == other.value && super(other)
    end

    def to_s
      value.to_s
    end
  end
end
