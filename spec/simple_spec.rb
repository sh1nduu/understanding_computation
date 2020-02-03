# frozen_string_literal: true

RSpec.describe Simple do
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

    context 'when each item are DoNothing' do
      let(:lhs) { DoNothing.new }
      let(:rhs) { lhs }
      it { is_expected.to be true }
    end

    context 'when compare DoNothing to another type' do
      let(:lhs) { DoNothing.new }
      let(:rhs) { Number.new(1) }
      it { is_expected.to be false }
    end

    context 'when each Assign have same name and expression' do
      let(:lhs) { Assign.new(:x, Number.new(1)) }
      let(:rhs) { lhs }
      it { is_expected.to be true }
    end

    context 'when each Assign have different name' do
      let(:lhs) { Assign.new(:x, Number.new(1)) }
      let(:rhs) { Assign.new(:y, Number.new(1)) }
      it { is_expected.to be false }
    end

    context 'when each Assign have same name but different expression' do
      let(:lhs) { Assign.new(:x, Number.new(1)) }
      let(:rhs) { Assign.new(:x, Number.new(2)) }
      it { is_expected.to be false }
    end

    context 'when each If have same attributes' do
      let(:lhs) { If.new(Boolean.new(true), DoNothing.new, Number.new(1)) }
      let(:rhs) { lhs }
      it { is_expected.to be true }
    end

    context 'when each If have different attributes' do
      let(:lhs) { If.new(Boolean.new(true), DoNothing.new, Number.new(1)) }
      let(:rhs) { If.new(Boolean.new(false), DoNothing.new, Number.new(1)) }
      it { is_expected.to be false }
    end

    context 'when each Sequence have same statements' do
      let(:lhs) { Sequence.new(Number.new(1), Number.new(2)) }
      let(:rhs) { lhs }
      it { is_expected.to be true }
    end

    context 'when each Sequence have different statements' do
      let(:lhs) { Sequence.new(Number.new(1), Number.new(2)) }
      let(:rhs) { Sequence.new(Number.new(2), Number.new(1)) }
      it { is_expected.to be false }
    end

    context 'when each While have same condition and body' do
      let(:lhs) { While.new(Boolean.new(true), Number.new(1)) }
      let(:rhs) { lhs }
      it { is_expected.to be true }
    end

    context 'when each While have different condition' do
      let(:lhs) { While.new(Boolean.new(true), Number.new(1)) }
      let(:rhs) { While.new(Boolean.new(false), Number.new(1)) }
      it { is_expected.to be false }
    end

    context 'when each While have different body' do
      let(:lhs) { While.new(Boolean.new(true), Number.new(1)) }
      let(:rhs) { While.new(Boolean.new(false), Number.new(2)) }
      it { is_expected.to be false }
    end
  end

  describe '#to_s' do
    subject { node.to_s }

    context 'of Number(1)' do
      let(:node) { Number.new(1) }
      it { is_expected.to eq '1' }
    end

    context 'of Boolean(true)' do
      let(:node) { Boolean.new(true) }
      it { is_expected.to eq 'true' }
    end

    context 'of Variable(:x)' do
      let(:node) { Variable.new(:x) }
      it { is_expected.to eq 'x' }
    end

    context 'of Add(1 + 2)' do
      let(:node) { Add.new(Number.new(1), Number.new(2)) }
      it { is_expected.to eq '1 + 2' }
    end

    context 'of Multiply(1 * 2)' do
      let(:node) { Multiply.new(Number.new(1), Number.new(2)) }
      it { is_expected.to eq '1 * 2' }
    end

    context 'of LessThan(1 < 2)' do
      let(:node) { LessThan.new(Number.new(1), Number.new(2)) }
      it { is_expected.to eq '1 < 2' }
    end

    context 'of nested(1 * 2 + 3 * 4)' do
      let(:node) do
        Add.new(
          Multiply.new(Number.new(1), Number.new(2)),
          Multiply.new(Number.new(3), Number.new(4))
        )
      end
      it { is_expected.to eq '1 * 2 + 3 * 4' }
    end

    context 'of Assign(x = 1)' do
      let(:node) { Assign.new(:x, Number.new(1)) }
      it { is_expected.to eq 'x = 1' }
    end

    context 'of If(if (true) { 1 } else { 2 })' do
      let(:node) { If.new(Boolean.new(true), Number.new(1), Number.new(2)) }
      it { is_expected.to eq 'if (true) { 1 } else { 2 }' }
    end

    context 'of Sequence(1; 2)' do
      let(:node) { Sequence.new(Number.new(1), Number.new(2)) }
      it { is_expected.to eq '1; 2' }
    end
  end
end
