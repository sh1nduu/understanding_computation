# frozen_string_literal: true

module Simple
  class Sequence < Node
    attr_accessor :first, :second
    def initialize(first, second)
      @first = first
      @second = second
    end

    def ==(other)
      super(other) && first == other.first && second == other.second
    end

    def to_s
      "#{first}; #{second}"
    end
  end
end
