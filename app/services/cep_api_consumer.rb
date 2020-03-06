class CepApiConsumer
  def self.query_result(cep)
    url = "https://viacep.com.br/ws/#{cep}/json/"
    response = Faraday.get url
    return if response.body.include?('erro') || response.status.eql?(400)

    json = JSON.parse(response.body, symbolize_names: true)
    json[:uf]
  end
end
