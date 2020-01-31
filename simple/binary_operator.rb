# frozen_string_literal: true

class BinaryOp < Node
  include Reducible

  attr_accessor :left, :right
  def initialize(left, right)
    self.left = left
    self.right = right
  end

  class << self
    attr_accessor :operator

    def use_symbol(operator)
      self.operator = operator
    end
  end

  def ==(other)
    left == other.left && right == other.right && self.class == other.class
  end

  def to_s
    "#{left} #{self.class.operator} #{right}"
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

    reduced_class.new(left.value.public_send(self.class.operator, right.value))
  end
end
