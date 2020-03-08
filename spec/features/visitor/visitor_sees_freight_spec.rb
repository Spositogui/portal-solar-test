require 'rails_helper'

feature 'User sees freight' do
  scenario 'successfully' do
    create(:power_generator, name: 'TRIFÁSICO 380V')
    json = File.read(Rails.root.join('spec/support/api_cep_response.json'))

    response = double('response', status: 200, body: json)
    allow(Faraday).to receive(:get).and_return(response)

    visit root_path
    click_on 'TRIFÁSICO 380V'
    fill_in 'CEP', with: '04602002'
    click_on 'Calcular Frete'

    expect(page).to have_content('Valor do Frete: R$ 100,00')
  end

  scenario 'and text wrong CEP' do
    generator = create(:power_generator)
    response = double('response', status: 200, body: { "erro": true }.to_json)
    allow(Faraday).to receive(:get).and_return(response)

    visit power_generator_path(generator.id)
    fill_in 'CEP', with: '99999999'
    click_on 'Calcular Frete'

    expect(page).to have_content('CEP não válido.')
    expect(page).not_to have_content('Valor do Frete:')
  end

  scenario 'and without CEP' do
    generator = create(:power_generator)
    response = double('response', status: 400, body: '')
    allow(Faraday).to receive(:get).and_return(response)

    visit power_generator_path(generator.id)
    click_on 'Calcular Frete'

    expect(page).to have_content('CEP não válido.')
    expect(page).not_to have_content('Valor do Frete:')
  end
end
