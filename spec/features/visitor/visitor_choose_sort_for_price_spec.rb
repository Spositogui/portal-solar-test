require 'rails_helper'

feature 'Visitor sort products for price' do
  scenario 'successfully' do
    create(:power_generator, name: 'JSL MONOFÁSICO', price: 10_000)
    create(:power_generator, name: 'POLI HALF CELL', price: 15_000)
    create(:power_generator, name: 'CELLS MONO PERC', price: 25_000)
    create(:power_generator, name: 'CELLS MONO JS', price: 5_000)
    create(:power_generator, name: 'WEG HÍBRIDO', price: 30_000)

    visit root_path
    find('#price-filter').fill_in 'Valor máximo', with: 11_000.00
    find('#price-btn-filter').click

    expect(page).to have_content('CELLS MONO JS')
    expect(page).to have_content('JSL MONOFÁSICO')
    expect(page).not_to have_content('POLI HALF CELL')
    expect(page).not_to have_content('CELLS MONO PERC')
    expect(page).not_to have_content('WEB HÍBRIDO')
  end

  scenario 'failed' do
    create(:power_generator, name: 'JSL MONOFÁSICO', price: 10_000)

    visit root_path
    find('#price-filter').fill_in 'Valor máximo', with: 9_999.99
    find('#price-btn-filter').click

    expect(page).to have_content('Nenhum resultado para a sua pesquisa foi'\
                                 ' encontrado.')
  end
end
