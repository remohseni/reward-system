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
                      file: { type: :binary },
                    },
                  },
                }

      response(200, 'successful') do
        let(:file) { File.join('spec', 'fixtures', 'sample_1.txt') }

        run_test! do |res|
          result = JSON.parse(res.body)

          expect(result).to eq({"status"=>"ok"})
        end
      end
    end
  end
end
