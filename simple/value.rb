# frozen_string_literal: true

class Value < Node
  include Reducible

  attr_accessor :value
  def initialize(value)
    self.value = value
  end

  def ==(other)
    value == other.value && self.class == other.class
  end

  def to_s
    value.to_s
  end
end
