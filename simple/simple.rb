# frozen_string_literal: true

require_relative './simple/small_step/reducible'
require_relative './simple/small_step/binary_operator'
require_relative './simple/small_step/variable'
require_relative './simple/node'
require_relative './simple/value'
require_relative './simple/binary_operator'
require_relative './simple/variable'
require_relative './simple/values'
require_relative './simple/operators'
require_relative './simple/small_step/machine'

module Simple
  include SmallStep

  class DoNothing < Node
    include SmallStep::Reducible

    def to_s
      'do-nothing'
    end

    def ==(other)
      other.instance_of?(self.class)
    end
  end

  class Assign < Node
    include SmallStep::Reducible
    reduce_to [].class

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

    def reduce(environment)
      if expression.reducible?
        [Assign.new(name, expression.reduce(environment)), environment]
      else
        [DoNothing.new, environment.merge(name => expression)]
      end
    end
  end
end
