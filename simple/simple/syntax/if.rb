# frozen_string_literal: true

module Simple
  class If < Node
    attr_accessor :condition, :consequence, :alternative
    def initialize(condition, consequence, alternative)
      @condition = condition
      @consequence = consequence
      @alternative = alternative
    end

    def to_s
      "if (#{condition}) { #{consequence} } else { #{alternative} }"
    end

    def ==(other)
      super(other) &&
        condition == other.condition &&
        consequence == other.consequence &&
        alternative == other.alternative
    end
  end
end
