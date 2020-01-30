# frozen_string_literal: true

require 'bundler/setup'
require './simple/simple.rb'

RSpec.describe 'Simple' do
  describe 'Operator' do
    it 'add' do
      op = Add.new(Number.new(1), Number.new(2))
      expect(op.to_s).to eq('1 + 2')
    end

    it 'multiply' do
      op = Multiply.new(Number.new(1), Number.new(2))
      expect(op.to_s).to eq('1 * 2')
    end

    it 'nested' do
      op = Add.new(
        Multiply.new(Number.new(1), Number.new(2)),
        Multiply.new(Number.new(3), Number.new(4))
      )
      expect(op.to_s).to eq('1 * 2 + 3 * 4')
    end
  end

  describe Reducible do
    let(:number) { Number.new(1) }
    let(:add) { Add.new(Number.new(1), Number.new(2)) }
    let(:mul) { Multiply.new(Number.new(1), Number.new(2)) }

    it 'Number is not reducible' do
      expect(number.reducible?).to eq(false)
    end

    it 'Add is reducible' do
      expect(add.reducible?).to eq(true)
    end

    it 'Multiply is reducible' do
      expect(mul.reducible?).to eq(true)
    end

    it 'Number#reduce' do
      expect { number.reduce }.to raise_error(NotImplementedError)
    end

    it 'Add#reduce' do
      add = Add.new(Number.new(1), Number.new(2))
      expect(add.reduce.value).to eq(3)
    end

    it 'Multiply#reduce' do
      mul = Multiply.new(Number.new(2), Number.new(3))
      expect(mul.reduce.value).to eq(6)
    end

    it 'Multiply#reduce when nested' do
      op = Multiply.new(
        Add.new(Number.new(1), Number.new(2)),
        Add.new(Number.new(3), Number.new(4))
      )
      expect(op.reduce.value).to eq(21) # (1 + 2) * (3 + 4)
    end
  end
end
