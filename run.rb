# frozen_string_literal: true

require './simple/simple.rb'

a = Add.new(Number.new(1), Number.new(2))
puts a
p a

a1 = Add.new(
  Multiply.new(Number.new(1), Number.new(2)),
  Multiply.new(Number.new(3), Number.new(4))
)
puts a1
p a1
