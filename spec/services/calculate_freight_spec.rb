require 'rails_helper'

describe CalculateFreight do
  describe '.value' do
    it 'sould return the freight value' do
      json = File.read(Rails.root.join('spec/support/api_cep_response.json'))
      json_parsed = JSON.parse(json, symbolize_names: true)

      response = double('response', status: 200, body: json)
      allow(Faraday).to receive(:get).and_return(response)

      result = CalculateFreight.value(json_parsed[:cep])

      expect(result.freight_value).to eq(100.0)
    end

    it 'should return Error if cep was blank' do
      response = double('response', status: 400, body: '')
      allow(Faraday).to receive(:get).and_return(response)

      result = CalculateFreight.value('')

      expect(result.freight_value).to eq('Error')
    end

    it 'should return Error if cep was wrong' do
      response = double('response', status: 400, body: '')
      allow(Faraday).to receive(:get).and_return(response)

      result = CalculateFreight.value('99999999')

      expect(result.freight_value).to eq('Error')
    end
  end
end
