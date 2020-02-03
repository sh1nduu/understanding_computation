# frozen_string_literal: true

module Simple
  class While < Node
    attr_accessor :condition, :body
    def initialize(condition, body)
      @condition = condition
      @body = body
    end

    def to_s
      "while (#{condition}) { #{body} } "
    end

    def ==(other)
      super(other) && condition == other.condition && body == other.body
    end
  end
end
