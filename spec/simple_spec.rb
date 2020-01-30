# frozen_string_literal: true

require 'bundler/setup'
require './simple/simple.rb'

RSpec.describe 'Simple' do
  describe '#to_s' do
    subject { expression.to_s }

    context 'of Number(1)' do
      let(:expression) { Number.new(1) }
      it { is_expected.to eq '1' }
    end

    context 'of Add(1 + 2)' do
      let(:expression) { Add.new(Number.new(1), Number.new(2)) }
      it { is_expected.to eq '1 + 2' }
    end

    context 'of Multiply(1 * 2)' do
      let(:expression) { Multiply.new(Number.new(1), Number.new(2)) }
      it { is_expected.to eq '1 * 2' }
    end

    context 'of nested(1 * 2 + 3 * 4)' do
      let(:expression) do
        Add.new(
          Multiply.new(Number.new(1), Number.new(2)),
          Multiply.new(Number.new(3), Number.new(4))
        )
      end
      it { is_expected.to eq '1 * 2 + 3 * 4' }
    end
  end
end

RSpec.describe Reducible do
  let(:number) { Number.new(1) }
  let(:add) { Add.new(Number.new(1), Number.new(2)) }
  let(:mul) { Multiply.new(Number.new(1), Number.new(2)) }

  describe '#reducible?' do
    subject { expression.reducible? }

    context 'of Number' do
      let(:expression) { number }
      it { is_expected.to eq false }
    end

    context 'of Add' do
      let(:expression) { add }
      it { is_expected.to eq true }
    end

    context 'of Multiply' do
      let(:expression) { mul }
      it { is_expected.to eq true }
    end
  end

  describe '#reduce' do
    subject { reducible.reduce }

    context 'of Number' do
      subject { -> { number.reduce } }
      it { is_expected.to raise_error NotImplementedError }
    end

    context 'of Add(1 + 2)' do
      let(:reducible) { Add.new(Number.new(1), Number.new(2)) }
      it { is_expected.to eq Number.new(3) }
    end

    context 'of Multiply(2 * 3)' do
      let(:reducible) { Multiply.new(Number.new(2), Number.new(3)) }
      it { is_expected.to eq Number.new(6) }
    end
  end
end

RSpec.describe Machine do
  describe '#run' do
    subject { machine.run }
    let(:machine) { Machine.new(expression) }

    context 'with Number(1)' do
      let(:expression) { Number.new(1) }
      it { is_expected.to eq expression }
    end

    context 'with Add(1 + 2)' do
      let(:expression) { Add.new(Number.new(1), Number.new(2)) }
      it { is_expected.to eq Number.new(3) }
    end

    context 'with Multiply((1 + 2) * (3 + 4))' do
      let(:expression) do
        Multiply.new(
          Add.new(Number.new(1), Number.new(2)),
          Add.new(Number.new(3), Number.new(4))
        )
      end
      it { is_expected.to eq Number.new(21) }
    end
  end
end
