# frozen_string_literal: true

require_relative './node'
require_relative './reducible'
require_relative './value'
require_relative './binary_operator'

class Machine
  attr_accessor :expression, :environment
  def initialize(expression, environment)
    @expression = expression
    @environment = environment
  end

  def step
    @expression = @expression.reduce(@environment)
  end

  def run
    step while @expression.reducible?
    @expression
  end
end

class Number < Value; end

class Boolean < Value; end

class Variable < Node
  include Reducible
  reduce_to Value

  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def ==(other)
    @name == other.name && self.class == other.class
  end

  def to_s
    name.to_s
  end

  def reduce(environment)
    environment.fetch(name)
  rescue KeyError
    raise "Undefined variable #{name}"
  end
end

class Add < BinaryOp
  use_symbol :+
  reduce_to Number
end

class Multiply < BinaryOp
  use_symbol :*
  reduce_to Number
end

class LessThan < BinaryOp
  use_symbol :<
  reduce_to Boolean
end
