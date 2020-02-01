# frozen_string_literal: true

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
