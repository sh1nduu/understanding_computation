# frozen_string_literal: true

module Simple
  class Assign < Node
    attr_accessor :name, :expression
    def initialize(name, expression)
      @name = name
      @expression = expression
    end

    def to_s
      "#{name} = #{expression}"
    end

    def ==(other)
      name == other.name && expression == other.expression && super(other)
    end
  end
end
