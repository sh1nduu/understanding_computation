# frozen_string_literal: true

module Simple
  class Variable < Node
    include SmallStep::Reducible
    include SmallStep::Variable
    reduce_to Value

    attr_accessor :name
    def initialize(name)
      @name = name
    end

    def ==(other)
      @name == other.name && super(other)
    end

    def to_s
      name.to_s
    end
  end
end
