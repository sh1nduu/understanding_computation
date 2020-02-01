# frozen_string_literal: true

require 'bundler/setup'
require './simple/simple.rb'

RSpec.describe 'Simple' do
  describe '#==' do
    subject { lhs == rhs }
    context 'when each Number are same values' do
      let(:lhs) { Number.new(1) }
      let(:rhs) { lhs }
      it { is_expected.to be true }
    end

    context 'when each Number are different values' do
      let(:lhs) { Number.new(1) }
      let(:rhs) { Number.new(2) }
      it { is_expected.to be false }
    end

    context 'when each Boolean are same values' do
      let(:lhs) { Boolean.new(true) }
      let(:rhs) { lhs }
      it { is_expected.to be true }
    end

    context 'when each Boolean are different values' do
      let(:lhs) { Boolean.new(true) }
      let(:rhs) { Boolean.new(false) }
      it { is_expected.to be false }
    end

    context 'when each Variable have a same name' do
      let(:lhs) { Variable.new(:x) }
      let(:rhs) { Variable.new(:x) }
      it { is_expected.to be true }
    end

    context 'when each Variable have different names' do
      let(:lhs) { Variable.new(:x) }
      let(:rhs) { Variable.new(:y) }
      it { is_expected.to be false }
    end

    context 'when each Add have same lhs and rhs' do
      let(:lhs) { Add.new(Number.new(1), Number.new(2)) }
      let(:rhs) { lhs }
      it { is_expected.to be true }
    end

    context 'when each Add have different lhs and rhs' do
      let(:lhs) { Add.new(Number.new(1), Number.new(2)) }
      let(:rhs) { Add.new(Number.new(2), Number.new(1)) }
      it { is_expected.to be false }
    end

    context 'when each Multiply have same lhs and rhs' do
      let(:lhs) { Multiply.new(Number.new(1), Number.new(2)) }
      let(:rhs) { lhs }
      it { is_expected.to be true }
    end

    context 'when each Multiply have different lhs and rhs' do
      let(:lhs) { Multiply.new(Number.new(1), Number.new(2)) }
      let(:rhs) { Multiply.new(Number.new(2), Number.new(1)) }
      it { is_expected.to be false }
    end

    context 'when each LessThan have same lhs and rhs' do
      let(:lhs) { LessThan.new(Number.new(1), Number.new(2)) }
      let(:rhs) { lhs }
      it { is_expected.to be true }
    end

    context 'when each LessThan have different lhs and rhs' do
      let(:lhs) { LessThan.new(Number.new(1), Number.new(2)) }
      let(:rhs) { LessThan.new(Number.new(2), Number.new(1)) }
      it { is_expected.to be false }
    end
  end

  describe '#to_s' do
    subject { expression.to_s }

    context 'of Number(1)' do
      let(:expression) { Number.new(1) }
      it { is_expected.to eq '1' }
    end

    context 'of Boolean(true)' do
      let(:expression) { Boolean.new(true) }
      it { is_expected.to eq 'true' }
    end

    context 'of Variable(:x)' do
      let(:expression) { Variable.new(:x) }
      it { is_expected.to eq 'x' }
    end

    context 'of Add(1 + 2)' do
      let(:expression) { Add.new(Number.new(1), Number.new(2)) }
      it { is_expected.to eq '1 + 2' }
    end

    context 'of Multiply(1 * 2)' do
      let(:expression) { Multiply.new(Number.new(1), Number.new(2)) }
      it { is_expected.to eq '1 * 2' }
    end

    context 'of LessThan(1 < 2)' do
      let(:expression) { LessThan.new(Number.new(1), Number.new(2)) }
      it { is_expected.to eq '1 < 2' }
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
  let(:boolean) { Boolean.new(true) }
  let(:variable) { Variable.new(:x) }
  let(:add) { Add.new(Number.new(1), Number.new(2)) }
  let(:mul) { Multiply.new(Number.new(1), Number.new(2)) }
  let(:less_than) { LessThan.new(Number.new(1), Number.new(2)) }

  describe '#reducible?' do
    subject { expression.reducible? }

    context 'of Number' do
      let(:expression) { number }
      it { is_expected.to be false }
    end

    context 'of Boolean' do
      let(:expression) { boolean }
      it { is_expected.to be false }
    end

    context 'of Varialbe' do
      let(:expression) { variable }
      it { is_expected.to be true }
    end

    context 'of Add' do
      let(:expression) { add }
      it { is_expected.to be true }
    end

    context 'of Multiply' do
      let(:expression) { mul }
      it { is_expected.to be true }
    end

    context 'of LessThan' do
      let(:expression) { less_than }
      it { is_expected.to be true }
    end
  end

  describe '#reduce' do
    subject { reducible.reduce(environment) }
    let(:environment) { {} }

    context 'of not reducible' do
      subject { -> { number.reduce } }
      it { is_expected.to raise_error NotImplementedError }
    end

    context 'of Variable(x)' do
      let(:reducible) { Variable.new(:x) }

      context 'with environment { x: Number(1) }' do
        let(:environment) { { x: Number.new(1) } }
        it { is_expected.to eq Number.new(1) }
      end

      context 'with blank environment' do
        subject { -> { reducible.reduce(environment) } }
        let(:environment) { {} }
        it { is_expected.to raise_error RuntimeError }
      end
    end

    context 'of Add(1 + 2)' do
      let(:reducible) { Add.new(Number.new(1), Number.new(2)) }
      it { is_expected.to eq Number.new(3) }
    end

    context 'of Multiply(2 * 3)' do
      let(:reducible) { Multiply.new(Number.new(2), Number.new(3)) }
      it { is_expected.to eq Number.new(6) }
    end

    context 'of LessThan(2 < 3)' do
      let(:reducible) { LessThan.new(Number.new(2), Number.new(3)) }
      it { is_expected.to eq Boolean.new(true) }
    end
  end
end

RSpec.describe Machine do
  describe '#run' do
    subject { machine.run }
    let(:machine) { Machine.new(expression, environment) }
    let(:environment) { {} }

    context 'with Number(1)' do
      let(:expression) { Number.new(1) }
      it { is_expected.to eq expression }
    end

    context 'with Boolean(true)' do
      let(:expression) { Boolean.new(true) }
      it { is_expected.to eq expression }
    end

    context 'with Add(1 + 2)' do
      let(:expression) { Add.new(Number.new(1), Number.new(2)) }
      it { is_expected.to eq Number.new(3) }
    end

    context 'with Varialbe(:x)' do
      let(:expression) { Variable.new(:x) }

      context 'when environment is { x: Number(1) }' do
        let(:environment) { { x: Number.new(1) } }
        it { is_expected.to eq Number.new(1) }
      end

      context 'when environment is { x: Number(1) }' do
        subject { -> { machine.run } }
        let(:environment) { {} }
        it { is_expected.to raise_error RuntimeError }
      end
    end

    context 'with LessThan(1 < 2)' do
      let(:expression) { LessThan.new(Number.new(1), Number.new(2)) }
      it { is_expected.to eq Boolean.new(true) }
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

    context 'Operator with Variable' do
      let(:expression) { Add.new(Number.new(1), Variable.new(:x)) }
      let(:environment) { { x: Number.new(1) } }
      it { is_expected.to eq Number.new(2) }
    end
  end
end
