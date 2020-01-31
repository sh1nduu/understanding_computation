# frozen_string_literal: true

require_relative './node'
require_relative './reducible'
require_relative './value'
require_relative './binary_operator'

class Machine < Struct.new(:expression)
  def step
    self.expression = expression.reduce
  end

  def run
    step while expression.reducible?
    expression
  end
end

class Number < Value; end

class Boolean < Value; end

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
