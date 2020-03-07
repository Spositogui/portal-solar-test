require 'rails_helper'

describe CepApiConsumer do
  describe '.query_result' do
    it 'should get CEP through API' do
      json = File.read(Rails.root.join('spec/support/api_cep_response.json'))
      js_parsed = JSON.parse(json, symbolize_names: true)
      response = double('response', status: 200, body: json)

      allow(Faraday).to receive(:get).and_return(response)

      result = CepApiConsumer.query_result(js_parsed[:cep])

      expect(result).to eq('SP')
    end

    it 'should return blank if cep not found' do
      response = double('response', status: 200, body: { "erro": true }.to_json)
      allow(Faraday).to receive(:get).and_return(response)

      result = CepApiConsumer.query_result('99999999')

      expect(result).to be_blank
    end

    it 'should return blank if the user does not enter any numbers' do
      response = double('response', status: 400, body: '')
      allow(Faraday).to receive(:get).and_return(response)

      result = CepApiConsumer.query_result('')

      expect(result).to be_blank
    end
  end
end
