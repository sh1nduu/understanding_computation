# frozen_string_literal: true

module Simple
  class Sequence < Node
    include SmallStep::Reducible
    include SmallStep::Sequence
    reduce_to [].class

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
