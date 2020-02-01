# frozen_string_literal: true

RSpec.describe Reducible do
  let(:number) { Number.new(1) }
  let(:boolean) { Boolean.new(true) }
  let(:variable) { Variable.new(:x) }
  let(:add) { Add.new(Number.new(1), Number.new(2)) }
  let(:mul) { Multiply.new(Number.new(1), Number.new(2)) }
  let(:less_than) { LessThan.new(Number.new(1), Number.new(2)) }
  let(:assign) { Assign.new(:x, Number.new(1)) }

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

    context 'of Assign' do
      let(:expression) { assign }
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

    context 'of Assign(x = 1)' do
      let(:reducible) { Assign.new(:x, Number.new(1)) }
      let(:environment) { {} }
      it { is_expected.to eq [DoNothing.new, { x: Number.new(1) }] }
    end
  end
end
