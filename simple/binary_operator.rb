# frozen_string_literal: true

class BinaryOp < Struct.new(:left, :right)
  include Node
  include Reducible

  class << self
    attr_accessor :operator

    def use_symbol(operator)
      self.operator = operator
    end
  end

  def to_s
    "#{left} #{self.class.operator} #{right}"
  end

  def inspect
    "«#{self}»"
  end

  def reduce
    if left.reducible?
      new_instance(left.reduce, right)
    elsif right.reducible?
      new_instance(left, right.reduce)
    else
      operate
    end
  end

  private
  def new_instance(*args)
    self.class.new(*args)
  end

  def operate
    raise "Can't reduce different types" unless left.class == right.class

    Number.new(left.value.public_send(self.class.operator, right.value))
  end
end
