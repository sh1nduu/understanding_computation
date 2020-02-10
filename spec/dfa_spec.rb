# frozen_string_literal: true

require './dfa/dfa'

RSpec.describe DFADesign do
  describe '#accepts?' do
    let(:rulebook) do
      DFARulebook.new(
        [
          FARule.new(1, 'a', 2), FARule.new(1, 'b', 1),
          FARule.new(2, 'a', 2), FARule.new(2, 'b', 3),
          FARule.new(3, 'a', 3), FARule.new(3, 'b', 3)
        ]
      )
    end
    let(:dfa_design) { DFADesign.new(1, [3], rulebook) }
    subject { dfa_design.accepts?(string) }

    context 'not accepts a' do
      let(:string) { 'a' }
      it { is_expected.to be false }
    end

    context 'not accepts baa' do
      let(:string) { 'baa' }
      it { is_expected.to be false }
    end

    context 'not accepts baba' do
      let(:string) { 'baba' }
      it { is_expected.to be true }
    end
  end
end
