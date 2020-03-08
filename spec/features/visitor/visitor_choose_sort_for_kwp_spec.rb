require 'rails_helper'

feature 'Visitor sort products for KWP' do
  scenario 'successfully' do
    create(:power_generator, name: 'JSL MONOFÁSICO', kwp: 2.68)
    create(:power_generator, name: 'POLI HALF CELL', kwp: 3.06)
    create(:power_generator, name: 'CELLS MONO PERC', kwp: 30.15)
    create(:power_generator, name: 'CELLS MONO JS', kwp: 23.14)
    create(:power_generator, name: 'WEG HÍBRIDO', kwp: 16.43)

    visit root_path
    find('#kwp-filter').fill_in 'KWP máximo', with: 5.40
    find('#kwp-btn-filter').click

    expect(page).to have_content('POLI HALF CELL')
    expect(page).to have_content('JSL MONOFÁSICO')
    expect(page).not_to have_content('CELLS MONO JS')
    expect(page).not_to have_content('CELLS MONO PERC')
    expect(page).not_to have_content('WEB HÍBRIDO')
  end

  scenario 'failed' do
    create(:power_generator, name: 'JSL MONOFÁSICO', kwp: 30.24)

    visit root_path
    find('#kwp-filter').fill_in 'KWP máximo', with: 30.20
    find('#kwp-btn-filter').click

    expect(page).to have_content('Nenhum resultado para a sua pesquisa foi'\
                                 ' encontrado.')
  end
end
