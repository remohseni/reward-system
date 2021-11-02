require 'rails_helper'

describe RewardSystem::CalculationService do
  describe '.call' do
    subject(:calculation_result) { described_class.call(data_file) }

    context 'with sample_1 file' do
      let(:data_file) { 'spec/fixtures/sample_1.txt' }
      let(:expected) do
        {
          'A' => 1.75,
          'B' => 1.5,
          'C' => 1
        }
      end

      it { is_expected.to eq(expected) }
    end

    context 'with sample_2 file' do
      let(:data_file) { 'spec/fixtures/sample_2.txt' }
      let(:expected) do
        {
          'A' => 3.5,
          'B' => 2,
          'E' => 1
        }
      end

      it { is_expected.to eq(expected) }
    end

    context 'with sample_3 file' do
      let(:data_file) { 'spec/fixtures/sample_3.txt' }
      let(:expected) do
        {
          'A' => 2.5,
          'B' => 1
        }
      end

      it { is_expected.to eq(expected) }
    end
  end
end
