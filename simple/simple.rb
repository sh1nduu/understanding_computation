# frozen_string_literal: true

require_relative './node'
require_relative './reducible'
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

class Number < Struct.new(:value)
  include Node
  include Reducible

  reducible false

  def to_s
    value.to_s
  end
end

class Add < BinaryOp
  use_symbol :+
  reducible true
end

class Multiply < BinaryOp
  use_symbol :*
  reducible true
end
