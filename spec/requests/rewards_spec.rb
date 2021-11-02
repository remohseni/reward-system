require 'swagger_helper'

RSpec.describe 'rewards', type: :request do
  path '/rewards/import' do
    post('import reward') do
      tags 'Rewards'
      consumes 'multipart/form-data'
      produces 'application/vnd.api+json'
      parameter name: 'file',
                description: 'Rewards file',
                in: :formData,
                attributes: {
                  schema: {
                    type: :object,
                    properties: {
                      file: { type: :binary }
                    }
                  }
                }

      response(200, 'successful', document: true) do
        context 'with sample_1 file' do
          let(:file) { File.join('spec', 'fixtures', 'sample_1.txt') }
          let(:expected) do
            {
              'A' => 1.75,
              'B' => 1.5,
              'C' => 1
            }
          end

          run_test! do |res|
            result = JSON.parse(res.body)
            expect(result).to eq(expected)
          end
        end

        context 'with sample_2 file' do
          let(:file) { File.join('spec', 'fixtures', 'sample_2.txt') }
          let(:expected) do
            {
              'A' => 3.5,
              'B' => 2,
              'E' => 1
            }
          end

          run_test! do |res|
            result = JSON.parse(res.body)
            expect(result).to eq(expected)
          end
        end

        context 'with sample_3 file' do
          let(:file) { File.join('spec', 'fixtures', 'sample_3.txt') }
          let(:expected) do
            {
              'A' => 2.5,
              'B' => 1
            }
          end

          run_test! do |res|
            result = JSON.parse(res.body)
            expect(result).to eq(expected)
          end
        end
      end
    end
  end
end
